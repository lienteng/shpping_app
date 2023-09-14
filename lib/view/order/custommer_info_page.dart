import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app99/model/customer.dart';
import 'package:shopping_app99/model/user.dart';
import 'package:shopping_app99/provider/user_provider.dart';
import 'package:shopping_app99/utils/helpers.dart';
import 'package:shopping_app99/view/common/custom_app_bar.dart';
import 'package:shopping_app99/view/common/custom_input_text.dart';

class CustomerInfoPage extends StatefulWidget {
  const CustomerInfoPage({super.key});

  @override
  State<CustomerInfoPage> createState() => _CustomerInfoPageState();
}

class _CustomerInfoPageState extends State<CustomerInfoPage> {
  UserProvider? userProvider;
  User? user;
  final box = Hive.box('myBox');
  TextEditingController textName = TextEditingController();
  TextEditingController textBuilding = TextEditingController();
  TextEditingController textShipping = TextEditingController();

  LatLng vientiane = LatLng(17.974855, 102.630867);
  LatLng latLng = LatLng(17.974855, 102.630867);
  late final MapController _mapController;
  List<Marker> marker = [];

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  getUserLogin() {
    User? u = User.fromJson(jsonDecode(box.get("current_user")));
    user = u;
    setState(() {});
  }

  void handleTap(LatLng lat) {
    marker.clear();
    marker.add(
      Marker(
        point: lat,
        builder: (ctx) => Container(
          child: const Icon(
            Icons.location_on,
            color: Colors.red,
            size: 30,
          ),
        ),
      ),
    );
    latLng = lat;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (userProvider == null) {
      userProvider = Provider.of<UserProvider>(context);
      getUserLogin();
    }
    SizedBox sizedBoxHeight = const SizedBox(height: 10);
    return Scaffold(
      appBar: CustomAppBar(
        title: Helpers.getString('customer__info'),
        leadingOnPress: () => Get.back(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        sizedBoxHeight,
                        Text(
                          '${Helpers.getString('customer__phone')}: ${user!.mobileNo}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        sizedBoxHeight,
                        CustomInputText(
                          text: Helpers.getString('customer__name'),
                          controller: textName,
                        ),
                        sizedBoxHeight,
                        CustomInputText(
                          text: Helpers.getString('customer__building_address'),
                          controller: textBuilding,
                        ),
                        sizedBoxHeight,
                        CustomInputText(
                          text: Helpers.getString('customer__shipping_address'),
                          controller: textShipping,
                        ),
                        sizedBoxHeight,
                        SizedBox(
                          height: 300,
                          width: double.infinity,
                          child: FlutterMap(
                            mapController: _mapController,
                            options: MapOptions(
                              center: vientiane,
                              zoom: 13,
                              onTap: (tapPosition, point) {
                                handleTap(point);
                              },
                            ),
                            children: [
                              TileLayer(
                                urlTemplate:
                                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                userAgentPackageName:
                                'dev.fleaflet.flutter_map.example',
                              ),
                              MarkerLayer(
                                markers: marker,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            MaterialButton(
              onPressed: () {
                Get.toNamed(
                  '/order-payment',
                  parameters: {
                    'phone': user!.mobileNo!,
                    'name': textName.text,
                    'building': textBuilding.text,
                    'shipping': textShipping.text,
                    'lat':'${latLng.latitude}',
                    'lng':'${latLng.longitude}',
                  },
                );
              },
              height: 50,
              color: Theme.of(context).primaryColor,
              minWidth: double.infinity,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                Helpers.getString('customer__next'),
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}