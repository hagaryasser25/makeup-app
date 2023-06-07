import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:makeup_app/models/category_model.dart';
import 'package:makeup_app/models/makeup_model.dart';
import 'package:makeup_app/pages/fetch-category.dart';
import 'package:makeup_app/services/makeup-service.dart';
import 'package:provider/provider.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../providers/makeup-provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    Provider.of<MakeupProvider>(context).getAllMemes();
    final makeup = Provider.of<MakeupProvider>(context).makeup;
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => Scaffold(
          body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 170,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/images/back.png"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'By Category',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Lobster',
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: StaggeredGridView.countBuilder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(
                left: 15.w,
                right: 15.w,
              ),
              crossAxisCount: 6,
              itemCount: cat.length,
              itemBuilder: (context, index) {
                return Container(
                  child: InkWell(
                    onTap: () {
                      
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return FetchCategory(
                          category: cat[index].name,
                        );
                      }));
                      
                    },
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(right: 10.w, left: 10.w),
                        child: Center(
                          child: Column(children: [
                            SizedBox(
                              height: 10.h,
                            ),
                            Image.asset('${cat[index].image}',
                                width: 130.w, height: 130.h),
                           
                            FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                '${cat[index].name}',
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Lobster',
                                    color: Colors.black),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ),
                );
              },
              staggeredTileBuilder: (int index) =>
                  new StaggeredTile.count(2, index.isEven ? 3 : 3),
              mainAxisSpacing: 3.0.h,
              crossAxisSpacing: 5.0.w,
            ),
          ),
        ],
      )),
    );
  }
}

List<Category> cat = [
  Category(
    name: 'Blush',
    image: 'assets/images/blusher.jpg',
  ),
  Category(
    name: 'Bronzer',
    image: 'assets/images/bronzer.jpg',
  ),
  Category(
    name: 'LipStick',
    image: 'assets/images/lipstick.jpg',
  ),
  Category(
    name: 'Foundation',
    image: 'assets/images/foundation.jpg',
  ),
  Category(
    name: 'Eyeliner',
    image: 'assets/images/eyeliner.png',
  ),
  Category(
    name: 'Eyeshadow',
    image: 'assets/images/eyeshadow.jpg',
  ),
];
