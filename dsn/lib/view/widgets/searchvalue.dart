import 'package:flutter/material.dart';

class SearchValueWidget extends StatefulWidget {
  final String hospitalname, hospitaladdress;
  final void Function() onPressed;
  const SearchValueWidget(
      {Key? key,
      required this.hospitalname,
      required this.hospitaladdress,
      required this.onPressed})
      : super(key: key);

  @override
  _SearchValueWidgetState createState() => _SearchValueWidgetState();
}

class _SearchValueWidgetState extends State<SearchValueWidget> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return TextButton(
      onPressed: widget.onPressed,
      child: Container(
        margin: const EdgeInsets.only(top: 25),
        width: width * 0.9,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
            color: Colors.white),
        padding: const EdgeInsets.all(25),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.hospitalname,
                      style: const TextStyle(color: Colors.black, fontSize: 12),
                    ),
                    Text(
                      widget.hospitaladdress,
                      style: const TextStyle(
                          color: Color.fromARGB(159, 19, 19, 19), fontSize: 10),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
