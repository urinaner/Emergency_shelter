import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timer_builder/timer_builder.dart';
import '../model/model.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen(
      {this.parseWeatherData,
      this.parseAirData,
      this.parseDisaster,
      this.parseMinLocation,
      this.parseMinLocationName});
  final parseWeatherData;
  final parseAirData;
  final parseDisaster;
  final parseMinLocation;
  final parseMinLocationName;

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Model model = Model();
  String? cityName;
  String? dismsg;
  String? disLocation;
  int? temp = 0;
  late Widget icon;
  String des = '';
  Widget? airIcon;
  Widget? airState;
  double dust1 = 0;
  double dust2 = 0;
  double? minkm;
  String? minname;
  var date = DateTime.now();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateData(
        widget.parseWeatherData,
        widget.parseAirData,
        widget.parseDisaster,
        widget.parseMinLocation,
        widget.parseMinLocationName);
  }

  void updateData(dynamic weatherData, dynamic airData, dynamic disData,
      dynamic minKm, dynamic minName) {
    double temp2 = weatherData['main']['temp'];
    temp = temp2.round();
    des = weatherData['weather'][0]['description'];
    int condition = weatherData['weather'][0]['id'];
    int index = airData['list'][0]['main']['aqi'];
    cityName = weatherData['name'];
    dust1 = airData['list'][0]['components']['pm10'];
    dust2 = airData['list'][0]['components']['pm2_5'];
    dismsg = disData['DisasterMsg'][1]['row'][0]['msg'];
    minname = minName;
    minkm = minKm;
    print(minKm);
    print(minName);
    print('ㅎㅇㅎㅇ');
    disLocation = disData['DisasterMsg'][1]['row'][0]['location_name'];
    print(disLocation);
    icon = model.getWeatherIcon(condition);
    airIcon = model.getAirIcon(index);
    airState = model.getAirCondition(index);
    print(temp);
    print(cityName);
  }

  String getSystemTime() {
    var now = DateTime.now();
    return DateFormat("h:mm a").format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        title: const Text('SALGIL'),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.near_me),
          onPressed: () {},
          iconSize: 30,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
            iconSize: 30,
          ),
        ],
      ),
      body: Container(
        child: Stack(
          children: [
            Image.asset(
              'image/background.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 150,
                            ),
                            Text(
                              '$cityName',
                              style: GoogleFonts.lato(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Row(
                              children: [
                                TimerBuilder.periodic(
                                    (const Duration(minutes: 1)),
                                    builder: (context) {
                                  print(getSystemTime());
                                  return Text(
                                    getSystemTime(),
                                    style: GoogleFonts.lato(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  );
                                }),
                                Text(
                                  DateFormat(' - EEEE, ').format(date),
                                  style: GoogleFonts.lato(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  DateFormat('d MMM, yyy').format(date),
                                  style: GoogleFonts.lato(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$temp\u2103',
                              style: GoogleFonts.lato(
                                fontSize: 90,
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                              ),
                            ),
                            Row(
                              children: [
                                icon,
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  des,
                                  style: GoogleFonts.lato(
                                    fontSize: 17,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Text(
                          '$dismsg',
                          style: GoogleFonts.lato(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const Divider(
                          height: 12,
                          endIndent: 12,
                          thickness: 1,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          '내 위치에서 가장 가까운 대피소',
                          style: GoogleFonts.lato(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '$minname , $minkm KM',
                          style: GoogleFonts.lato(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'AI 행동강령',
                          style: GoogleFonts.lato(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          '비상시 신속히 응급용품을 가지고 대피할 수 있도록 사전에 배낭 등에 모아둡니다.∙ 상수도 공급이 중단 될 수 있으므로, 욕조 등에 미리 물을 받아둡니다.∙ 재난정보 수신을 위해 스마트폰에 안전디딤돌 앱이 설치되었는지 확인하고 가까운 행정복지센터(주민센터) 등과 긴급 연락망을 확인합니다.',
                          style: GoogleFonts.lato(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      const Divider(
                        height: 15,
                        thickness: 2.0,
                        color: Colors.white30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                'AQI(대기질지수)',
                                style: GoogleFonts.lato(
                                  fontSize: 17,
                                  color: Colors.white,
                                ),
                              ),
                              airIcon!,
                              airState!,
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                '미세먼지',
                                style: GoogleFonts.lato(
                                  fontSize: 17,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                '$dust1',
                                style: GoogleFonts.lato(
                                  fontSize: 24,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'ug/m3',
                                style: GoogleFonts.lato(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                '초미세먼지',
                                style: GoogleFonts.lato(
                                  fontSize: 17,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                '$dust2',
                                style: GoogleFonts.lato(
                                  fontSize: 24,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'up/m3',
                                style: GoogleFonts.lato(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
