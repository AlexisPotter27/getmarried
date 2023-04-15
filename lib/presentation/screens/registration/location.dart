import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:getmarried/presentation/screens/registration/privacy_screen.dart';
import 'package:getmarried/widgets/button.dart';
import '../../../di/injector.dart';
import '../../../models/user.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/cache_cubit/cache_cubit.dart';

class Location extends StatefulWidget {
  const Location({Key? key}) : super(key: key);

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  AuthBloc authBloc = AuthBloc(getIt.get());
  UserData? cachedUser = getIt.get<CacheCubit>().user;

  String location = 'Null';
  String? Address;
  String? Country;

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location Service are disabled');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> getAddressFromLatLng(Position position) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemark);

    Placemark place = placemark[0];
    Address = '${place.subLocality}, ${place.isoCountryCode} ';
    Country = '${place.country}';
    print('Location:: ${Address}');
    cachedUser?.location = Address;
    cachedUser?.country = Country;
    authBloc.add(UpdateUserEvent(cachedUser!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Image.asset(
          'assets/ilogo.png',
          width: 60,
          height: 60,
        ),
        elevation: 0,
        backgroundColor: Colors.indigoAccent,
      ),
      backgroundColor: Colors.indigoAccent,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Center(
                    child: CircleAvatar(
                      radius: 32,
                      backgroundColor: Colors.black,
                      child: CircleAvatar(
                        backgroundColor: Colors.yellow,
                        radius: 30,
                        child: Icon(
                          Icons.location_on,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Where are you?",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Your location services need to be turned \n on in order for this to work.',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Button(
                      colour: Colors.white,
                      title: 'Enable location',
                      ontap: () async {
                        //_getCurrentPosition();
                        requestForLocation();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PrivacyScreen()));
                      },
                      textcolour: Colors.black),
                  const SizedBox(
                    height: 50,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  void requestForLocation()async{
    Position position = await _determinePosition();
    print(position.latitude);
    location = '${position.latitude}, ${position.longitude}';
    getAddressFromLatLng(position);
  }
}
