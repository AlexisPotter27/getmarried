import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:getmarried/presentation/screens/registration/privacy_screen.dart';
import 'package:getmarried/widgets/button.dart';
import '../../../di/injector.dart';
import '../../../helper/toastMessage.dart';
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


  //String? _currentAddress;
  //Position? _currentPosition;

  // Location Permission
 /* Future<bool> _handleLocationPermission() async{
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }*/

  // Get Current Position
 /* Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
      ToastMessage.showToast('Location enabled!');
    }).catchError((e) {
      debugPrint(e);
    });
  }*/

  // Get Address From Lat and Lng
  /*Future<void> _getAddressFromLatLng(Position position) async {
        await placemarkFromCoordinates(
            _currentPosition!.latitude,
            _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }*/

  String location = 'Null';
  String? Address;

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
    print('Location:: ${Address}');
    cachedUser?.location = Address;
    authBloc.add(UpdateUserEvent(cachedUser!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title:  Image.asset('assets/ilogo.png', width: 60, height: 60,),
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
                    'Your location services need to be turned\non in order for this to work.',
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
                        Position position = await _determinePosition();
                        print(position.latitude);
                        location = '${position.latitude}, ${position.longitude}';
                        getAddressFromLatLng(position);

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
}
