//////////////////////////////////a wave  fundamental as notes
(
SynthDef.new(\id, {
	arg a=2,pos=1,el1=0,el2=0,az1=0,az2=0,az3=0,b=1,gain=1;
	var freq=1,sum1=0,sum2=0;
	var x=1,wave1,wave2,envelope;
	var decay=1,ton1=110,ton2=220,y;

	el1=LFSaw.ar(4/3); el2=LFSaw.ar(3/2);az1=LFSaw.ar(3/2); az2=LFSaw.ar(4/3);

	1.do{ 2.do{  x=x+1; y=((x**a)+a)/x;
		//wave1=SinOsc.ar(y*ton1,mul: (1/y));  sum1 = sum1+wave1;
		wave2=SinOsc.ar(y*ton1,mul: (1/y));  sum2= sum2+wave2};
	//Out.ar(4,PanAz.ar(2,sum1,el1));
    Out.ar(4,PanAz.ar(2,sum2,el2))};
	  Out.ar(0,PanAz.ar(2,InFeedback.ar(4)*gain,az1));
      Out.ar(2,PanAz.ar(2,InFeedback.ar(5)*gain,az2));
}).add;
)
(
(Synth.new(\id,[\a,1,\gain,1]));
(Synth.new(\id,[\a,2,\gain,1/2]));
)

	//envelope=EnvGen.ar(Env.new([0,0.7,0.5,0.5,0],[0.1,0.6,0.4,0.8],[-4]),doneAction:2);



////////////////////////////////////////////////////////////////////////////////////installation pattern
////////////////////////////////////////////////////////////////////////////////////////////////////
((a= Pdef(\pat3, Pbind(\instrument, \iter_d,
	\dur,1/4,
	\a,Pseq([2,3,1,4,2,4,2,3],inf),
	//\el,Pfunc({~el}),
	\az1,Pfunc({~az2}),
	\az2,Pfunc({~az1});
	//\b,Prand([1,2,3,4],inf),
)).play(quant:1));
))


s.options.numOutputBusChannels=9;
TempoClock.default.tempo_(120/120);
ServerOptions.inDevices.postln;
s.record(numChannels:2);
s.options.sampleRate =48000;
s.options.device_("USB Sound Device");
s.options.memSize = 65536;
s.options.memSize
s.options.numInputBusChannels=0;
s.record(numChannels:2) ;

