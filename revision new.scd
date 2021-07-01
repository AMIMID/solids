TempoClock.default.tempo_(120/60);
ServerOptions.inDevices.postln;
s.record(numChannels:2);
s.options.sampleRate =48000;
s.options.device_("ASIO : ASIO4ALL v2");
s.options.numOutputBusChannels=6;
s.options.memSize = 65536;
s.options.memSize
s.options.numInputBusChannels=0;
MIDIClient.init;
MIDIIn.connectAll;
~notes0=Array.newClear(128);
s.record(numChannels:2) ;

///////////////////////////////////////////////////////
(
(SynthDef(\solids1,{
	arg ton=220,a=1,gate=0,bend=[8,-8],gain=1/2;
	var x=0,y=1,freq,dur,mul,sidea=0,side1,bus=0,envelope,mono,p1;
	//sidea=SinOsc.ar(ton);
	3.do{
		x=x+1;      y= ((x+a)/x);      freq=(y*ton);      mul=(1/y);      dur= (y/mul);    envelope=EnvGen.kr(Env.perc(dur,dur,gain,bend),gate,doneAction:2);
		//side1 =(SinOsc.ar(freq*1,mul:mul)+SinOsc.ar(freq*3,mul:mul*(1/3))+SinOsc.ar(freq*5,mul:mul*(1/5))+SinOsc.ar(freq*7,mul:mul*(1/7)));
		side1=SinOsc.ar(freq,mul:mul)*envelope;
		sidea=(sidea+side1); p1=sidea*envelope};
	Out.ar(bus,p1)}).add
);
(
(MIDIdef.noteOn(\noteOnTest, { arg vel,nn,chan,src; [nn,vel].postln;
	~notes0[nn] = Synth.new(\solids1,[\ton, nn.midicps,\gate,1]);
}));
(
MIDIdef.noteOff(\noteOffTest, { arg vel,nn;
	~notes0[nn].set(\gate,0);
	~notes0[nn] = nil;
}));
)
)

Tdef(\1).play;


(
Tdef(\1,
      {

				 1.do({(f= Pdef(\pat1, Pbind(\instrument, \solids1,
	\dur,Prand([1],inf),
           \ton, Prand([220,440,256,110],inf),
			\gate,1,
)).play(quant:1));

			(1).yield});
			})
)

/////////////////////////////
(SynthDef(\solids1,{
arg ton=220,a=1,dur,offset=1,pan1=1,pan2=1,gate=0;
	var frequency1=1, x1=0, y1=0, gain1=1/100, duration1=6,  envelope1=1,mul1=1,spat1=0, stereo=0, dual=0, sound=0,azimuth1,azimuth2,mono,quaternion,cube1,cube2,spat,pan,
	      frequency2=1, x2=0, y2=0, gain2=1/100, duration2=6,  envelope2=1,mul2=1,spat2=0,signal1,elevation,audio,
	      frequency3=1, x3=0, y3=0, gain3=1/100, duration3=6,  envelope3=1,mul3=1,spat3=0,quad=0,quad1=0,signal2;

	pan=LFSaw.ar(0.111);

	3.do{
		x2=x2+1;
	y2 = ((x2+a)/x2).postln;
	mul2=(gain2/y2);
	duration2= (y2);
	 frequency2=(y2*ton);
	envelope2=EnvGen.kr(Env.sine(duration2),doneAction:2);
		dual = SinOsc.ar(frequency2,mul: mul2)*envelope2;
	stereo = stereo +dual; stereo=stereo*envelope2;
		signal1=BLowPass.ar(LFSaw.ar(mul2),ton)*envelope2;
		spat1=spat1+signal1; spat1=spat1*envelope2;
	};
	Out.ar(0,stereo);




}).add

)