import 'package:dcoin/repository/contents_repository.dart';
import 'package:dcoin/utils/data_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late ContentsRepository contentsRepository; // = ContentsRepository();
  late String currentLocation;
  final Map<String, String> locationTypeToString = {
    "ara": "아라동",
    "ora": "오라동",
    "donam": "도남동",
  };
  late bool isLoading;

  @override
  void initState() {
    super.initState();
    currentLocation = "ara";
    isLoading = false;
  }

  @override
  void didChangeDependencies() {
    print("didChangeDependencies~~~~~~");
    super.didChangeDependencies();
    contentsRepository = ContentsRepository();
  }

  /*
   * appBar Widget 구현 
   * Widget return error(2.8)
   */
  PreferredSizeWidget _appbarWidget() {
    return AppBar(
      title: GestureDetector(
        onTap: () {
          print('click');
        },
        // onLongPress: () {
        //   print('long pressed~~~');
        // },
        child: PopupMenuButton<String>(
          offset: const Offset(0, 25),
          // shape: ShapeBorder.lerp(
          //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          //     1),
          onSelected: (value) {
            print('appBar selected value = $value');
            setState(() {
              currentLocation = value;
            });
          },
          itemBuilder: (context) {
            return [
              const PopupMenuItem(value: "ara", child: Text("아라동")),
              const PopupMenuItem(value: "ora", child: Text("오라동")),
              const PopupMenuItem(value: "donam", child: Text("도남동")),
            ];
          },
          child: Row(children: [
            Text(locationTypeToString[currentLocation].toString()),
            const Icon(Icons.arrow_drop_down),
          ]),
        ),
      ),
      elevation: 1, // 그림자를 표현되는 높이 3d 측면의 높이를 뜻함.
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.tune)),
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            "assets/svg/bell.svg",
            width: 22,
          ),
        ),
      ],
    );
  }

  Widget _bodyWidget() {
    return FutureBuilder(
      future: _loadContents(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          // loading
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          print(snapshot.error);
          return const Center(child: Text("데이터 오류"));
        }
        if (snapshot.hasData) {
          // return Center(child: Text("데이터 존재 ${snapshot.data}"));
          List<Map<String, String>> _data =
              snapshot.data as List<Map<String, String>>;
          if (_data.isEmpty) {
            return const Center(child: Text("해당 지역에 데이터가 없습니다."));
          }

          return _makeDataList(_data);
        }
        return const Center(child: Text("해당 지역에 데이터가 없습니다."));
      },
    );
  }

  Future<List<Map<String, String>>> _loadContents() async {
    List<Map<String, String>> responseData =
        await contentsRepository.loadContentsFromLocation(currentLocation);
    return responseData;
  }

  Widget _makeDataList(List<Map<String, String>> datas) {
    return ListView.separated(
      itemCount: 10,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          // 라인이 전체 길이가 됨
          // padding: const EdgeInsets.all(10),
          // 이미지와 라인 길이가 맞지 않음. ListView padding으로처리.
          // margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Image.asset(
                datas[index]["image"].toString(),
                width: 100,
                height: 100,
              ),
            ),
            Expanded(
              child: Container(
                height: 100,
                padding: const EdgeInsets.only(left: 20),
                // width: MediaQuery.of(context).size.width,
                // color: Colors.blue,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      datas[index]["title"].toString(),
                      style: const TextStyle(fontSize: 15),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      datas[index]["location"].toString(),
                      style: TextStyle(
                          fontSize: 12, color: Colors.black.withOpacity(0.3)),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      DataUtils.calcStringToWon(
                          datas[index]["price"].toString()),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    // Container(
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SvgPicture.asset(
                            "assets/svg/heart_off.svg",
                            width: 14,
                            height: 14,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(datas[index]["likes"].toString()),
                          // 숫자 사이 간격 SizedBox 또는 아래와 같이
                          // Padding(
                          //   padding: const EdgeInsets.only(left: 5),
                          //   child: Text(datas[index]["likes"].toString()),
                          // ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ]),
        );
      },
      separatorBuilder: (context, index) {
        return Container(
          height: 1,
          color: Colors.black.withOpacity(0.4),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbarWidget(),
      body: _bodyWidget(),
      // bottomNavigationBar: Container() 기본으로 설정시 화면 전체를 차지해서 덮어버림.
      // 다른 화면이 안보임
      // bottomNavigationBar: _bottomNavigationBarwidget(),
    );
  }
}
