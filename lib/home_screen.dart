import 'package:far_cry_6_parallax/model.dart';
import 'package:far_cry_6_parallax/parallax.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ParallaxWidget(
        parallaxData: [
          Parallax(
            title: "",
            description: "",
            image: "assets/images/poster.jpg",
            alignment: const Alignment(0, 0),
          ),
          Parallax(
            title: "TRUST YOUR LEADER",
            description:
                "As the leaders of Yara, my son Diego and I will restore this nation back to its former glory",
            image: "assets/images/leader.jpg",
            alignment: const Alignment(-.45, 0),
          ),
          Parallax(
            title: "BEWARE OF THE DICTATOR",
            description:
                "Antón will even sacrifice his own people to forge his paradise, he is a rutheless man, DO NOT TRUST HIM.",
            image: "assets/images/dictator.jpg",
            alignment: const Alignment(-.45, 0),
          ),
          Parallax(
            title: "GUERRILLA FIGHTERS DESTROY CAPITOL",
            description:
                "Dani Rojas and his band of guerillas are traitors to our great country who seek to destroy us.",
            image: "assets/images/destroy.jpg",
            alignment: const Alignment(.6, 0),
          ),
          Parallax(
            title: "GUERRILLA FIGHTERS DEFEND FREEDOM",
            description:
                "We fight to liberate our nation from the oppression of a ruthless tyrant, to give power back to its people.",
            image: "assets/images/defend.jpg",
            alignment: const Alignment(.6, 0),
          ),
          Parallax(
            title: "MEET DANI ROJAS",
            description:
                "Twin of Dan Rojas, who is captured by Antón's forces. She seeks to save his brother.",
            image: "assets/images/dani_female.jpg",
            alignment: const Alignment(-.65, 0),
          ),
          Parallax(
            title: "MEET DAN ROJAS",
            description:
                "Twin of Dani Rojas, who is captured by Antón's forces. He seeks to save his sister.",
            image: "assets/images/dani_male.jpg",
            alignment: const Alignment(-.65, 0),
          ),
        ],
      ),
    );
  }
}
