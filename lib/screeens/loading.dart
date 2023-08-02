import 'package:flutter/material.dart';
import 'package:flutter_huf_project/screeens/weather_screen.dart';
import '../data/my_location.dart';
import '../data/network.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../data/dis_location.dart';

const apikey = 'c8f74dfb21cb1440f297b2dc608a8a71';
const apikey2 =
    "V7GqQuNPFr7BW9lTC%2F8%2Bd6%2F8iu653AZHsgn%2FgKrciYV8AAEYM8yX1satHogBb5zNmjNP1VLo1xaHEEd9D4XckQ%3D%3D";
const pageNumber = 1;

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  double latitude3 = 0;
  double longitude3 = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
  }

  void getLocation() async {
    //class 사용하기 위해 초기화 및 할당
    MyLocation myLocation = MyLocation();
    await myLocation.getMyCurrentLocation();
    latitude3 = myLocation.latitude2;
    longitude3 = myLocation.latitude2;
    DisLocation disLocation = DisLocation(latitude3, longitude3);
    await disLocation.getMinLocation();
    var minKm = disLocation.minKm;
    var minName = await disLocation.getMinLocation();
    print(minName);

    Network network = Network(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude3&lon=$longitude3&appid=$apikey&units=metric',
        'https://api.openweathermap.org/data/2.5/air_pollution?lat=$latitude3&lon=$longitude3&appid=$apikey',
        'http://apis.data.go.kr/1741000/DisasterMsg3/getDisasterMsg1List?serviceKey=$apikey2&pageNo=$pageNumber&numOfRows=10&type=json');

    var weatherData = await network.getJsonData();
    // print(weatherData);

    var airData = await network.getAirData();

    var disData = await network.getDisaster();
    // print(disData);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          //loading된 데이터를 Navigator로 페이지 전환과 동시에 데이터 전송
          return WeatherScreen(
              parseWeatherData: weatherData,
              parseAirData: airData,
              parseDisaster: disData,
              parseMinLocation: minKm,
              parseMinLocationName: minName);
        },
      ),
    );
  }

  // void fetchData() async {

  //   } else {
  //     print(response.statusCode);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}
