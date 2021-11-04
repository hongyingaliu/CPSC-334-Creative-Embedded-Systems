//boot server
s.boot;
//address and port for osc
n = NetAddr.new("172.29.21.84", 57121);

//set audio output to "JBL GO"
Server.default.options.inDevice_("JBL GO");
Server.default.options.outDevice_("JBL GO");

//ambient tone synth
(
SynthDef(\tone, {arg freq = 40, nharm = 12, detune = 0.2, gate = 1, pan = 0.4, amp = 4, out = 0;
	var sig, env;
	env = EnvGen.kr(Env.adsr(0.05,0.1,0.5,3), gate);
	sig = Blip.ar(
		freq *
		LFNoise1.kr(0.2!16).bipolar(detune.neg, detune).midiratio,nharm
	);
	sig = sig * LFNoise1.kr(0.5!16).exprange(0.1,1);
	sig = Splay.ar(sig);
	sig = Balance2.ar(sig[0], sig[1], pan);
	sig = sig * env * amp;
	Out.ar(out, sig);
}).add
)

b = Synth.new(\knock);

//knocking synth
(
SynthDef(\knock,{|voiced=1 freq= 440 amp=0.1 resonancescaling=5 gate=0|
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

//gong synth
(
SynthDef(\gongFM, {
	arg ratio1=0.9, ratio2=0.55, ratio3=1.03, index2=2, index3=4, amp=0.3, dur=4, pan=0;
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

//bird sounds synth
(
SynthDef(\forest_bird_pj, { |out=0, amp=0.1, pan=0|
	Out.ar(out, Pan2.ar(
		BPF.ar(BrownNoise.ar,SinOsc.kr(LFNoise2.kr(50,50,50),0,100,2000),0.001,10)
		* amp, pan))},
metadata: (
	credit: "by Paul Jones, posted to sc-users mailing list 2007-04-07",
	tags: [\forest, \bird]
	)
).add;
)

b = Buffer.read(s, "/Users/AlanaLiu/Downloads/Ancient Chinese Chants of the Song Dynasty.wav");

b.play;

//function triggered by capacitative
(
v = OSCFunc( { | msg, time, addr, port |
    var py_data;

	py_data = msg[1].asFloat;
	if (py_data > 80,{
		a.set(\freq, 5);
		c.set(\freq, 0);
				//a.free;
			},{})
}, '/cap' );

//function triggered by light sensor 2
a = Synth.new( \tone);
c = Synth.new(\voicesound6);
d = Synth.new(\forest_bird_pj);

x = OSCFunc( { | msg, time, addr, port |
    var py_data;

	py_data = msg[1].asFloat;
    a.set( \freq, py_data * 0.1 + 20);
}, '/light2' );

//function triggered by light sensor 4
y = OSCFunc( { | msg, time, addr, port |
    var py_data;
	py_data = msg[1].asFloat;
    a.set( \amp, py_data * 0.005 + 1);
}, '/light4' );

//function triggered by light sensor 3
z = OSCFunc( { | msg, time, addr, port |
    var py_data; 

	py_data = msg[1].asFloat;
    c.set( \freq, py_data * 0.005 + 1);
}, '/light3' );

//function triggered by piezo
j = OSCFunc( { | msg, time, addr, port |
    var py_data;

	py_data = msg[1].asFloat;
	if (py_data > 300,{
		Synth(\gongFM, [\ratio1, 0.59, \ratio2, 0.17, \ratio3, 0.75, \index2, 1.54, \index3, 3.29]);
				//a.free;
			},{})
}, '/piezo' );

//function triggered by light sensor 1
k = OSCFunc( { | msg, time, addr, port |
    var py_data;

	py_data = msg[1].asFloat;
	if (py_data > 10,{
		d.set(\amp, 0.1);
				//a.free;
	},{d.set(\amp, 0);})
}, '/light1' );

)
