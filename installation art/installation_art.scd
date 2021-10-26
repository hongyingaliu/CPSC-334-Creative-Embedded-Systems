s.boot;
n = NetAddr.new("172.29.21.84", 57121);


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

b = Synth.new(\voicesound6);


(
SynthDef(\voicesound6,{|voiced=1 freq= 440 amp=0.1 resonancescaling=5 gate=0|
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
a = Synth.new( \tone);

x = OSCFunc( { | msg, time, addr, port |
    var pyFreq;

	pyFreq = msg[1].asFloat;
    ( "freq is " + pyFreq ).postln;
    a.set( \freq, pyFreq * 0.1);
	//a.set(\resonancescaling, pyFreq*0.01);
	//a.set(\nharm, pyFreq*0.01);
	//0.01.wait;
}, '/light1' );

y = OSCFunc( { | msg, time, addr, port |
    var pyFreq;

	pyFreq = msg[1].asFloat;
    ( "freq is " + pyFreq ).postln;
    a.set( \amp, pyFreq * 0.005);
	//a.set(\resonancescaling, pyFreq*0.01);
	//a.set(\nharm, pyFreq*0.01);
	//0.01.wait;
}, '/light2' );
)


b = Buffer.read(s, "/Users/AlanaLiu/Downloads/Ancient Chinese Chants of the Song Dynasty.wav");

b.play;
b.pause;

(
SynthDef(\playbuf , {arg out=1, bufnum=0, rate=1, trigger=1, startPos=0, loop=1;
	Out.ar(out, Pan2.ar(PlayBuf.ar(1,bufnum, BufRateScale.kr(bufnum)*rate, trigger, BufFrames.ir(bufnum)*startPos, loop),0.0)
	)
}).add;
)

d = Synth.new(\playbuf);

d.set(\startPos, 0)
