import 'package:flutter/material.dart';
import 'package:flutter_2kbr/data/models/weather_forecast.dart';
import 'package:flutter_2kbr/data/services/api_service.dart';
import 'package:flutter_2kbr/pages/home_page.dart';
import 'package:flutter_2kbr/pages/login_page.dart';
import 'package:flutter_2kbr/providers/auth_provider.dart';
import 'package:flutter_2kbr/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  List<WeatherForecast> _weatherForecasts = [];

  @override
  void initState() {
    super.initState();
    _fetchWeatherForecasts();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      if (!authProvider.isLoggedIn) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
          (route) => false,
        );
      }
    });
  }

  Future<void> _fetchWeatherForecasts() async {
    List<WeatherForecast> fetchedForecasts =
        await ApiService().getWeatherForecast();
    setState(() {
      _weatherForecasts = fetchedForecasts;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: CustomAppBar(
        onActionPressed: () {
          if (authProvider.isLoggedIn) {
            authProvider.logout();
            // navigate to home page after logging out
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          } else {
            _navigateToLogin();
          }
        },
      ),
      body: Center(
        child: _weatherForecasts.isEmpty
            ? CircularProgressIndicator()
            : ListView.builder(
                itemCount: _weatherForecasts.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue.shade100,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${_weatherForecasts[index].date}',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Temperature: ${_weatherForecasts[index].temperatureC}°C',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Summary: ${_weatherForecasts[index].summary}',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.wb_sunny,
                          size: 40,
                          color: Colors.orange.shade300,
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }

  Future<void> _navigateToLogin() {
    return Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    ).then((_) {
      setState(() {});
    });
  }
}
