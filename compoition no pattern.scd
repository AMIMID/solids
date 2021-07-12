//////////////////////////////////a wave  fundamental as notes////bell pare ta arxidia mou///tetraedro apla pramata

(
(
SynthDef.new(\id, {
	arg a=2,decay=6,ton=110,x=1,organ;
	var freq=1,sum=0;
	var wave,envelope,y,step=(-1);
	ton=ton/a;
	4.do{  x=x+1; y=((x**a)+a)/(x**(1/1));
		envelope=EnvGen.ar(Env.perc(decay/organ,decay,1/a,1,[-2,-4]),doneAction:2);
		wave=BLowPass.ar(LFSaw.ar(y*ton,mul: (1/y)),y*ton,1);  sum= sum+wave;
	};
	Out.ar(0,wave*envelope);

}).add;
);
(
SynthDef.new(\it, {
	arg a=2,decay=6,ton=110,x=1,organ;
	var freq=1,sum=0;
	var wave,envelope,y,step=(-1);
	ton=ton/a;
	4.do{  x=x+1; y=((x**a)+a)/(x**(1/1));
		envelope=EnvGen.ar(Env.perc(decay/organ,decay,1/a,1,[-2,-4]),doneAction:2);
		wave=BLowPass.ar(LFSaw.ar(y*ton,mul: (1/y)),y*ton,1);  sum= sum+wave;
	};
	Out.ar(1,wave*envelope);

}).add;
)
)
(
~pot1 = MIDIFunc.cc( { arg vel,nn,chan,src; [vel,nn,chan,src];  ~a= vel.linlin(6,87,55,110).round.postln; "a".postln}, 71, 0);
~pot2 = MIDIFunc.cc( { arg vel,nn,chan,src; [vel,nn,chan,src];  ~b= vel.linlin(14,124,55,110).round.postln;"b".postln}, 73, 0);
)

MIDIClient.init;
MIDIIn.connectAll;

////////////////////////////////////////////////////////////////////////////////////installation pattern
////////////////////////////////////////////////////////////////////////////////////////////////////
((
c= Pdef(\ii, Pbind(\instrument, \id,
			\a,Pseq([1,2,3,5],inf),
	\ton,Pfunc({~a}),
	\dur,1,
		\organ,Prand([4,200,400,100],inf),
	\decay,1.5;
)).play(quant:1));
(
c= Pdef(\i, Pbind(\instrument, \it,
			\a,Pseq([5,3,2,1],inf),
	\ton,Pfunc({~b}),
	\dur,0.5,
	\organ,Prand([4,200,400,100,],inf),
	\decay,0.6;
)).play(quant:1))
)




s.options.numOutputBusChannels=8;
TempoClock.default.tempo_(120/50);
ServerOptions.inDevices.postln;
s.record(numChannels:2);
s.options.sampleRate =48000;
s.options.device_("USB Sound Device");
s.options.memSize = 65536;
s.options.memSize
s.options.numInputBusChannels=0;
s.record(numChannels:2) ;

