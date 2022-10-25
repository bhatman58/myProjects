import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class audioPlay extends StatefulWidget {
  String audioPath;
  String audioName;
  audioPlay({this.audioPath, this.audioName});
  @override
  _audioPlayState createState() => _audioPlayState();
}

class _audioPlayState extends State<audioPlay> {
  AudioPlayer audioPlayer = AudioPlayer();
  bool playing = false;
  String durationM = "0";
  String durationS = "0";
  String positionS = "0";
  String positionM = "0";

  Duration _duration = new Duration();
  Duration _position = new Duration();

  playLocal(String filedir) async {
    int result = await audioPlayer.play(
      filedir,
      isLocal: true,
      stayAwake: true,
    );
    print("RESULT IS : " + result.toString());
    await audioPlayer.setReleaseMode(ReleaseMode.RELEASE);
  }

  @override
  void initState() {
    super.initState();
    audioPlayer.onPlayerStateChanged.listen(
        (AudioPlayerState s) => print("current state is : " + s.toString()));

    audioPlayer.onAudioPositionChanged.listen((Duration p) => setState(() {
          positionS = p.inSeconds.toString();
          positionS = positionS.substring(0, 2);
          positionM = p.inMinutes.toString();
          _position = p;
        }));

    audioPlayer.onDurationChanged.listen((Duration d) {
      durationM = d.inMinutes.toString();
      durationS = d.inSeconds.toString();
      durationS = durationS.substring(0, 2);
      setState(() {
        _duration = d;
      });
    });
  }

  void seekToSecond(int second) {
    Duration newDuration = Duration(seconds: second);

    audioPlayer.seek(newDuration);
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.stop();
    audioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var wi = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () {
        print("POPED");
        audioPlayer.stop();
        audioPlayer.dispose();
        Navigator.pop(context);
      },
      child: Scaffold(
          body: Container(
        width: wi,
        height: he,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: he * .1),
                child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    setState(() {
                      playing = !playing;
                    });
                    playing ? playLocal(widget.audioPath) : audioPlayer.pause();
                  },
                  child: Icon(
                    playing ? Icons.pause : Icons.play_arrow,
                    size: wi * .15,
                    color: Colors.green[400],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: he * .15,
                margin: EdgeInsets.only(bottom: he * .25),
                child: Slider(
                    value: _position.inSeconds.toDouble(),
                    min: 0,
                    max: _duration.inSeconds.toDouble(),
                    activeColor: Colors.green,
                    inactiveColor: Colors.blueGrey,
                    onChanged: (double value) {
                      setState(() {
                        seekToSecond(value.toInt());
                        value = value;
                      });
                    }),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  height: he * .15,
                  margin: EdgeInsets.only(bottom: he * .21),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Text(
                          positionM +
                              " : " +
                              positionS +
                              " / " +
                              durationM +
                              " : " +
                              durationS,
                        ),
                      ),
                      Container(
                        child: Text(durationM + " : " + durationS),
                      ),
                    ],
                  )),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                  height: he * .15,
                  // margin: EdgeInsets.only(bottom: he * .21),
                  child: Text(
                    widget.audioName,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(fontFamily: 'ir-sans', fontSize: wi * .03),
                  )),
            ),
          ],
        ),
      )),
    );
  }
}

// child: Stack(
//           children: <Widget>[
//             Align(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Container(
//                     child: IconButton(
//                       onPressed: () {
//                         setState(() {
//                           playing = !playing;
//                         });
//                         playing
//                             ? playLocal(widget.audioPath)
//                             : audioPlayer.pause();
//                       },
//                       icon: Icon(playing ? Icons.pause : Icons.play_arrow),
//                     ),
//                   ),
//                   Align(
//                     alignment: Alignment.center,
//                     child: Slider(
//                         value: _position.inSeconds.toDouble(),
//                         min: 0,
//                         max: _duration.inSeconds.toDouble(),
//                         onChanged: (double value) {
//                           setState(() {
//                             seekToSecond(value.toInt());
//                             value = value;
//                           });
//                         }),
//                   )
//                 ],
//               ),
//             ),
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: Container(
//                 margin: EdgeInsets.only(bottom: 200),
//                 child: Text("Duration : " + durationM + ":" + durationS),
//               ),
//             ),
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: Container(
//                 margin: EdgeInsets.only(left: 300, bottom: 200),
//                 child: Text("position : " +
//                     positionM +
//                     " : " +
//                     positionS +
//                     " / " +
//                     durationM +
//                     " : " +
//                     durationS),
//               ),
//             ),
//           ],
//         ),
