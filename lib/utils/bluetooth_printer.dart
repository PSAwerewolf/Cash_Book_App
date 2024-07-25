import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:cash_book_app4/utils/dimentions.dart';
import 'package:cash_book_app4/widgets/big_text.dart';
import 'package:cash_book_app4/widgets/small_text.dart';
import 'package:flutter/material.dart';

import 'app_icon.dart';

class BluetoothPrinter extends StatefulWidget {
  const BluetoothPrinter({super.key});

  @override
  State<BluetoothPrinter> createState() => _BluetoothPrinterState();
}

class _BluetoothPrinterState extends State<BluetoothPrinter> {
  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;
  List<BluetoothDevice> _devices = [];
  String deviceMsg = '';
  bool _connected = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => {initPrinter()});
  }

  Future<void> initPrinter() async {
    startScan();
    if (!mounted) return;
    bluetoothPrint.scanResults.listen((val) {
      if (!mounted) return;
      setState(() {
        _devices = val;
      });
      if (_devices.isEmpty) {
        setState(() {
          deviceMsg = "No Devices Found";
        });
      }
    });
  }

  void stateCheck() {
    bluetoothPrint.state.listen((state) {
      print('cur device status: $state');

      switch (state) {
        case BluetoothPrint.CONNECTED:
          setState(() {
            _connected = true;
          });
          break;
        case BluetoothPrint.DISCONNECTED:
          setState(() {
            _connected = false;
          });
          break;
        default:
          break;
      }
    });
  }

  void startScan() {
    bluetoothPrint.startScan(timeout: Duration(seconds: 4));
  }

  Future<void> connectDevice(_device) async {
    await bluetoothPrint.connect(_device);
  }

  Future<void> disconnectDevice() async {
    await bluetoothPrint.disconnect();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimentions.pageView220,
      child: _devices.isEmpty
          ? Center(
              child: BigText(text: deviceMsg),
            )
          : ListView.builder(
              itemCount: _devices.length,
              itemBuilder: (c, i) {
                return ListTile(
                  leading: AppIcon(
                    iconData: Icons.print,
                  ),
                  title: BigText(
                    text: '${_devices[i].name}',
                  ),
                  subtitle: SmallText(text: "${_devices[i].address}"),
                  onTap: () {
                    connectDevice(_devices[i]);
                  },
                );
              },
            ),
    );
  }
}
