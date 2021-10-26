s.boot;
ServerOptions.new
ServerOptions.devices;
ServerOptions.outDevices;
//Server.default.options
//Server.default.options.device_("Alana Bose QC35 II")
//Server.default.options.inDevice_("Alana Bose QC35 II");
//Server.default.options.outDevice_("Alana Bose QC35 II");
Server.default.options.inDevice_("Bluetooth");
Server.default.options.outDevice_("Bluetooth");

OSCFunc.trace(true);
OSCFunc.trace(false);

n = NetAddr.new("172.29.21.84", 57120);

n.sendMsg("/hello", "there");
(
f = { |msg, time, addr|
    if(msg[0] != '/status.reply') {
        "time: % sender: %\nmessage: %\n".postf(time, addr, msg);
    }
};
thisProcess.addOSCRecvFunc(f);
);
thisProcess.removeOSCRecvFunc(f);

(
SynthDef(\voicesound6,{|voiced=1 freq= 440 amp=0.1 resonancescaling=5|
var formantfreqs, formantamps, formantbandwidths; //data for formants
var periodicsource, aperiodicsource, source, output;
var vibrato;
var vibratonoise= LFNoise1.kr(10);
formantfreqs= [800,1150,2900,3900,4950]; //centre frequencies of formants
formantamps= ([0 ,-6,-32,-20,-50]-6).dbamp; //peaks of formants
formantbandwidths=[80,90,120,130,140];  //bandwidth
vibrato= ((freq.cpsmidi)+(Line.kr(0.0,1.0,2.5)*SinOsc.kr(6+(1.0*vibratonoise),0,0.5))).midicps;
periodicsource= LPF.ar(Impulse.ar(vibrato),5000);
aperiodicsource= PinkNoise.ar(0.7);
source= (voiced*periodicsource)+((1.0-voiced)*aperiodicsource);

output= Mix(Formlet.ar(source, formantfreqs, 0.001, resonancescaling*formantbandwidths.reciprocal, formantamps))*10*amp;

Out.ar(0,output.dup)

}).add
)

(
SynthDef(\gongFM, {
	arg ratio1=0.9, ratio2=0.55, ratio3=1.03, index2=2, index3=4, amp=0.7, dur=7, pan=0;
	var sig, op1, op2, op3, env1, env2, env3;
	env3 = EnvGen.kr(Env.new([0, 1, 1, 0], [0.4, 0.3, dur]), doneAction:2);
	env2 = EnvGen.kr(Env.new([0, 1, 1, 0], [0, 0.3, dur]), doneAction:2);
	env1 = EnvGen.kr(Env.new([0, 1, 1, 0], [0.003, 0.3, dur - 0.5]), doneAction:2);
	op3 = SinOsc.ar(([67, 70, 74].midicps * ratio3), mul:[67, 70, 74].midicps * ratio3 * index3) * env3;
	op2 = SinOsc.ar((([67, 70, 74].midicps * ratio2) + op3), mul:[67, 70, 74].midicps * ratio2 * index2) * env2;
	op1 = SinOsc.ar(([67, 70, 74].midicps * ratio1) + op2);
	sig = op1 * env1 * amp;
	sig = Splay.ar(sig);
	sig = Balance2.ar(sig[0], sig[1], pan);
	Out.ar(0, sig);
}).add;
)

a = Synth(\gongFM, [\ratio1, 0.59, \ratio2, 0.17, \ratio3, 0.75, \index2, 1.54, \index3, 3.29])

b = Synth(\voicesound6)

(
SynthDef(\saw, {
	arg cutoff = 1000;
	var sig;
	sig = Saw.ar([50,51]);
	sig = RLPF.ar(sig, cutoff.lag(0.02), 0.25, 02);
	Out.ar(0, sig);
}).add;
)

c = Synth(\saw, [\cutoff, 200])

(
~control = Routine.new({
	{
		OSCdef(\light_data, {|msg, time, addr, recvPort|
			//msg.postln;
			if (msg != 0,{
				c.set(\cutoff, msg.linexp(0, 1023, 80, 4000));
				0.01.wait;
				//a.free;
			},{b.free;})
		}, "/light");
	}.loop;
}).play;
)

s.freeAll
