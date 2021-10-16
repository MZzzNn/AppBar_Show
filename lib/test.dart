import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  ScrollController scrollController=ScrollController();
  var showAppBar=false;

  @override
  void initState() {
    scrollController.addListener(() {
      double currentScroll = scrollController.position.pixels;
      if ( currentScroll >= 150) {
        setState(() {showAppBar=true;});
      }else{
        setState(() {showAppBar=false;});
      }
    });
    super.initState();
  }
  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    print(AppBar().preferredSize.height);
    return Scaffold(
      body: SafeArea(
        child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                SingleChildScrollView(
                  controller: scrollController,
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context,index)=>Card(
                              elevation: 5,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Image(
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                image: NetworkImage('https://image.freepik.com/free-photo/bearded-man-denim-shirt-round-glasses_273609-11770.jpg'),
                              ),
                            ),
                          separatorBuilder: (context,index)=>SizedBox(height: 10,),
                          itemCount: 10
                      )
                    ],
                  ),
                ),
                Positioned(
                    top: 0,
                    right: 0,
                    left: 0,
                    child: Container(
                      color: showAppBar?Colors.white:Colors.grey.withOpacity(0.05),
                      height: AppBar().preferredSize.height,
                      width: double.infinity,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 50,
                              margin: EdgeInsets.all(10),
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                  color:showAppBar?Colors.grey[200]: Colors.white,
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.search),
                                  Text('Search product')
                                ],
                              ),
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Icon(Icons.email,color:showAppBar?Colors.grey: Colors.white,),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Icon(Icons.notifications,color:showAppBar?Colors.grey: Colors.white,),
                          ),
                        ],
                      ),
                    )
                ),
              ],
            )
        ),
      ),
    );
  }
}
