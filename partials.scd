//////////////////////////////////a wave  fundamental as notes
(
(SynthDef.new(\iter_d, {
	arg a=1,pos=1,el=0,az1=0,az2=0,az3=0;
	var freq=1,sum=0,audio,x=0,y,wave,partial=3,envelope,decay=5,ton=220;
	  partial.do{  x=x+1;    y=(x+a)/x;   freq=ton*y;
		envelope=EnvGen.ar(Env.new([0,1,1,0],[1/y,decay,y],[4,0,-8]),doneAction:2);
		wave=SinOsc.ar(freq,mul: (1/y))*envelope*(1/partial);  sum = sum+wave};

	  Out.ar(6,PanAz.ar(3,sum*envelope,el));
	  Out.ar(0,PanAz.ar(2,InFeedback.ar(6)*envelope,az1));
      Out.ar(2,PanAz.ar(2,InFeedback.ar(7)*envelope,az2));
      Out.ar(4,PanAz.ar(2,InFeedback.ar(8)*envelope,az3));
}).add;
);

((a= Pdef(\pat3, Pbind(\instrument, \iter_d,
	\dur,Pseq([1],inf),
	\a,Pseq([1,2,3,1,3,1,2],inf),
	\el,Pfunc({~el}),
	\az1,Pfunc({~az1}),
	\az2,Pfunc({~az2}),
	\az3,Pfunc({~az3});
)).play(quant:1));
))

(
~pot1 = MIDIFunc.cc( { arg vel,nn,chan,src; [vel,nn,chan,src].postln;  ~az1 = vel.linlin(20,100,-0.5,0.5)}, 70, 0);
~pot2 = MIDIFunc.cc( { arg vel,nn,chan,src; [vel,nn,chan,src].postln;  ~az2= vel.linlin(20,127,-0.5,0.5)}, 71, 0);
~pot2 = MIDIFunc.cc( { arg vel,nn,chan,src; [vel,nn,chan,src].postln;  ~az3 = vel.linlin(20,100,-0.5,0.5)}, 72, 0);
~pot2 = MIDIFunc.cc( { arg vel,nn,chan,src; [vel,nn,chan,src].postln;  ~el = vel.linlin(32,127,-1,1)}, 73, 0);
)


s.options.numOutputBusChannels=9;

(
//s.options.device_("ASIO : ASIO4ALL v2");
s.options.numOutputBusChannels=9;
//TempoClock.default.tempo_(120/60);
MIDIClient.init;
MIDIIn.connectAll;
)


