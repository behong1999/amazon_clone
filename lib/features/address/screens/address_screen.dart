import 'package:amazon_clone/common/widgets/custom_textfield.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/address/services/address_services.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  final String totalAmount;
  const AddressScreen({
    Key? key,
    required this.totalAmount,
  }) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController buildingController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();

  String usedAddress = "";
  List<PaymentItem> paymentItems = [];
  final AddressServices addressServices = AddressServices();

  late final Future<PaymentConfiguration> _googlePayConfigFuture;
  late final Future<PaymentConfiguration> _applePayConfigFuture;

  @override
  void initState() {
    super.initState();
    _googlePayConfigFuture =
        PaymentConfiguration.fromAsset('google_pay_config.json');
    _applePayConfigFuture =
        PaymentConfiguration.fromAsset('apple_pay_config.json');
    paymentItems.add(
      PaymentItem(
        amount: widget.totalAmount,
        label: 'Total Amount',
        status: PaymentItemStatus.final_price,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    buildingController.dispose();
    cityController.dispose();
  }

  void onApplePayResult(res) {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddress(context: context, address: usedAddress);
    }
    addressServices.placeOrder(
      context: context,
      address: usedAddress,
      sum: double.parse(widget.totalAmount),
    );
  }

  void onGooglePayResult(res) {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddress(context: context, address: usedAddress);
    }
    addressServices.placeOrder(
      context: context,
      address: usedAddress,
      sum: double.parse(widget.totalAmount),
    );
  }

  void payPressed(String addressFromProvider) {
    usedAddress = "";

    bool isNotEmpty =
        buildingController.text.isNotEmpty || cityController.text.isNotEmpty;

    if (isNotEmpty) {
      if (_addressFormKey.currentState!.validate()) {
        usedAddress = '${buildingController.text},  ${cityController.text}';
      } else {
        throw Exception('Please enter all the values!');
      }
    } else if (addressFromProvider.isNotEmpty) {
      usedAddress = addressFromProvider;
    } else {
      showSnackBar(context, 'ERROR');
    }
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVar.appBarGradient,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          address,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'OR',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              Form(
                key: _addressFormKey,
                child: Column(
                  children: [
                    CustomTextfield(
                      controller: buildingController,
                      hintText: 'Street name and number',
                    ),
                    const SizedBox(height: 10),
                    CustomTextfield(
                      controller: cityController,
                      hintText: 'Town/City',
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              FutureBuilder<PaymentConfiguration>(
                  future: _applePayConfigFuture,
                  builder: (context, snapshot) {
                    return snapshot.hasData
                        ? ApplePayButton(
                            width: double.infinity,
                            style: ApplePayButtonStyle.whiteOutline,
                            type: ApplePayButtonType.buy,
                            paymentConfiguration: snapshot.data,
                            onPaymentResult: onApplePayResult,
                            paymentItems: paymentItems,
                            margin: const EdgeInsets.only(top: 15),
                            height: 50,
                            onPressed: () => payPressed(address),
                          )
                        : const SizedBox.shrink();
                  }),
              const SizedBox(height: 10),
              FutureBuilder<PaymentConfiguration>(
                  future: _googlePayConfigFuture,
                  builder: (context, snapshot) {
                    return snapshot.hasData
                        ? GooglePayButton(
                            paymentConfiguration: snapshot.data,
                            onPaymentResult: onGooglePayResult,
                            type: GooglePayButtonType.buy,
                            loadingIndicator: const Center(
                              child: CircularProgressIndicator(),
                            ),
                            paymentItems: paymentItems,
                            margin: const EdgeInsets.only(top: 15),
                            height: 50,
                            onPressed: () => payPressed(address),
                          )
                        : const SizedBox.shrink();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
