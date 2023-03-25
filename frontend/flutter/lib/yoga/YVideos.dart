import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:zenith/globalvariables.dart';

class VideoPlayerScreen extends StatefulWidget {
  int number;
  VideoPlayerScreen({required this.number});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  List<String> title = ['Mental Yoga', 'Physical Yoga', 'General Yoga'];
  List<String> dataSource = ['assets/y1.mp4', 'assets/y2.mp4', 'assets/y3.mp4'];
  List<String> asanas = ["Siddhasana", "Vajrasana", "Paschimottanasana"];
  List<String> asanaInfo = [
    'Method: \n\nThis is the most easy pose of Yoga where you sit cross-legged with eyes closed deep in meditation and hands resting on your knees. Sit with your toes tucked into your thighs and set your feet side by side while keeping your knees wide and eyes closed in a meditative pose to ace the seated asana.',
    'Method: \n\nStart by kneeling on the floor and rest your pelvis on your heels. Keep your heels close to each other by pulling your knees and ankles together and point your feet in line with your legs. Place your palms on your knees or on your thighs and adjust your pelvis slightly backward and forward until you re comfortable. Exhale as you sit back on your legs. ',
    'Method: \n\nBegin with Dandasana and place a strap around the feet while grasping them by the hands if the back is stiff. Ensure that your knees are slightly bent and legs stretched out forward.Then inhale and extend your arms straight out to the sides and up over your head, reaching toward the ceiling while keeping your spine erect. As you exhale and empty your stomach of air, begin to come forward by hinging at your hips and place your upper body on your lower body.'
  ];
  Color mainColor = Colors.white;
  late VideoPlayerController _controller;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(dataSource[widget.number])
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  //var darkData;

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: GlobalVariables.secondaryColor,
        appBar: AppBar(
          backgroundColor: GlobalVariables.backgroundColor,
          //foregroundColor: Colors.black,

          elevation: 0.0,
          title: Text(
            title[widget.number],
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          //backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              _controller.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10.0),
                                bottomRight: Radius.circular(10.0)),
                          ),
                          margin: const EdgeInsets.only(
                              left: 10.0, top: 10.0, right: 10.0, bottom: 20.0),
                          child: VideoPlayer(_controller)),
                    )
                  : Container(),

              //video progress indicator
              Container(
                  decoration: const BoxDecoration(
                    //color: Colors.blue,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0)),
                  ),
                  margin: const EdgeInsets.only(
                      left: 10.0, top: 10.0, right: 10.0, bottom: 20.0),
                  child: VideoProgressIndicator(_controller,
                      allowScrubbing: true)),

              //following code is for button controller
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      _controller.pause();
                      setState(() {
                        _controller = VideoPlayerController.asset(
                            dataSource[widget.number])
                          ..initialize().then((_) {
                            setState(() {});
                          });
                      });
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) => VideoPlayerApp3()))
                    },
                    icon: const Icon(
                      Icons.skip_previous,
                      size: 40,
                    ),
                    color: GlobalVariables.lightbackgroundColor,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _controller.value.isPlaying
                            ? _controller.pause()
                            : _controller.play();
                      });
                    },
                    icon: Icon(
                      _controller.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                      size: 40,
                    ),
                    color: GlobalVariables.lightbackgroundColor,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  IconButton(
                    onPressed: () {
                      _controller.pause();
                      _controller = VideoPlayerController.asset(
                          dataSource[(widget.number + 1) % 3])
                        ..initialize().then((_) {
                          setState(() {
                            widget.number = (widget.number + 1) % 3;
                          });
                        });
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) => VideoPlayerApp2()))
                    },
                    icon: const Icon(Icons.skip_next, size: 40),
                    color: GlobalVariables.lightbackgroundColor,
                  ),
                ],
              ),
              Text(
                asanas[widget.number],
                style: const TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Text(
                  asanaInfo[widget.number],
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
