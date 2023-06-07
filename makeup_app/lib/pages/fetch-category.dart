import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../providers/makeup-provider.dart';

class FetchCategory extends StatefulWidget {
  String category;
  FetchCategory({required this.category});

  @override
  State<FetchCategory> createState() => _FetchCategoryState();
}

class _FetchCategoryState extends State<FetchCategory> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {});
    Provider.of<MakeupProvider>(context, listen: false)
        .getByCategory(widget.category);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => Scaffold(body: Consumer<MakeupProvider>(
        builder: (context, provider, _) {
          return Column(
            children: [
              Container(
                height: 150.h,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 34, 34, 34),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 40.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 20.w),
                      child: Row(
                        children: [
                          SizedBox(width: 10.w),
                          CircleAvatar(
                            radius: 20,
                            backgroundColor:
                                Color.fromARGB(255, 63, 63, 63), //<-- SEE HERE
                            child: IconButton(
                              icon: Center(
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                provider.category.clear();
                              },
                            ),
                          ),
                          SizedBox(
                            width: 180.w,
                          ),
                          Image.asset('assets/images/logo.png',
                              height: 50.h, width: 150.h),
                        ],
                      ),
                    ),
                    Text(
                      '${widget.category}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              provider.category.isEmpty
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Expanded(
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      children:[
                        Container(
                        child: StaggeredGridView.countBuilder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.only(
                            left: 15.w,
                            right: 15.w,
                          ),
                          crossAxisCount: 6,
                          itemCount: provider.category.length,
                          itemBuilder: (context, index) {
                            return Container(
                              child: InkWell(
                                onTap: () {
                                  /*
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return FetchCategory(
                                      category: provider.category[index].name,
                                    );
                                  }));
                                  */
                                },
                                child: Card(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(right: 10.w, left: 10.w),
                                    child: Center(
                                      child: Column(children: [
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Image.network(
                                            '${provider.category[index].image}',
                                            width: 130.w,
                                            height: 130.h),
                                        Text(
                                          '${provider.category[index].name}',
                                          style: TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Lobster',
                                              color: Colors.black),
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
                              new StaggeredTile.count(3, index.isEven ? 3 : 3),
                          mainAxisSpacing: 3.0.h,
                          crossAxisSpacing: 5.0.w,
                        ),
                      ),
                      ] 
                    ),
                  )
            ],
          );
        },
      )),
    );
  }
}
