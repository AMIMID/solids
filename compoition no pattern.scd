//////////////////////////////////a wave  fundamental as notes////bell pare ta arxidia mou///tetraedro apla pramata

(
(
SynthDef.new(\id, {
	arg a=2,az1=0,az2=0,az3=0,gain=0.1,decay=6,ton=109;
	var freq=1,sum=0,sum2=0;
	var x=1,wave,envelope,y;
gain= 1/a;
	ton=ton/a;
	2.do{2.do{  x=x+1; y=((x**a)+a)/(x**(1/a));
		envelope=EnvGen.ar(Env.perc(0.01,decay,1,[6,-2]),doneAction:2);
			wave=SinOsc.ar(y*ton,mul: (1/y));  sum= sum+wave;
	};
	Out.ar(0,sum*envelope);
	}

}).add;
);
(
SynthDef.new(\it, {
	arg a=2,az1=0,az2=0,az3=0,gain=0.1,decay=6,ton=220;
	var freq=1,sum=0,sum2=0;
	var x=1,wave,envelope,y;
gain= 1/a;
	ton=ton/a;
	2.do{2.do{  x=x+1; y=((x**a)+a)/(x**(1/a));
		envelope=EnvGen.ar(Env.perc(0.01,decay,1,[6,-2]),doneAction:2);
			wave=SinOsc.ar(y*ton,mul: (1/y));  sum= sum+wave;
	};
	Out.ar(1,sum*envelope);
	}

}).add;
)
)
(
(Synth.new(\id,[\a,2,\gain,1,\az1,1/2,\az2,3/4,\az3,2/3,\decay,3]));
s.record(numChannels:2) ;
)

~pot1 = MIDIFunc.cc( { arg vel,nn,chan,src; [vel,nn,chan,src].postln;  ~a= vel.linlin(6,87,1,4)}, 71, 0);

MIDIClient.init;
MIDIIn.connectAll;

////////////////////////////////////////////////////////////////////////////////////installation pattern
////////////////////////////////////////////////////////////////////////////////////////////////////
((
a= Pdef(\ii, Pbind(\instrument, \id,
	\a,Prand([2,8],inf),
	\dur,0.1,
	\decay,1;
)).play(quant:1));
(
a= Pdef(\i, Pbind(\instrument, \it,
	\a,Prand([2,8],inf),
	\dur,0.2,
	\decay,1;
)).play(quant:1))
)



s.options.numOutputBusChannels=8;
TempoClock.default.tempo_(120/120);
ServerOptions.inDevices.postln;
s.record(numChannels:2);
s.options.sampleRate =48000;
s.options.device_("USB Sound Device");
s.options.memSize = 65536;
s.options.memSize
s.options.numInputBusChannels=0;
s.record(numChannels:2) ;

