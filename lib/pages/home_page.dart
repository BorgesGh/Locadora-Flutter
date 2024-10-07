import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import '../widgets/MeuScaffold.dart';

class HomePage extends StatelessWidget{

  List<String> imagens = ["Locadora.png","Locadora2.jpg","Locadora3.jpeg"];

  @override
  Widget build(BuildContext context) {
    return MeuScaffold(
      texto: "Locadora",
      body:
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text("Ultimas noticias"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(2),topRight: Radius.circular(2))
                  ),
                  // child: Swiper(
                  //   pagination: const SwiperPagination(),
                  //   itemCount: imagens.length,
                  //   itemHeight: 400,
                  //   itemWidth: 500,
                  //   viewportFraction: 0.8,
                  //   scale: 0.9,
                  //   controller: SwiperController(),
                  //   layout: SwiperLayout.TINDER,
                  //   scrollDirection: Axis.horizontal,
                  //   itemBuilder: (context,index){
                  //     return Image.asset(imagens[index],
                  //     fit: BoxFit.fill);
                  //   },
                  // ),
                )
              ],
            ),
            const Row(),
          ],
        )
      );
  }
}