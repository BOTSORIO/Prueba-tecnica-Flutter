import 'package:flutter/material.dart';
import 'package:prueba_celuweb/src/providers/providers.dart';
import 'package:prueba_celuweb/src/ui/inputDecoration.dart';

DateTime selectedDate = DateTime.now();
String description = '';

void displayDialog(BuildContext context) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: false,
          body: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  AlertDialog(
                    title: const Text(
                      '¡Confirmar pedido!',
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(
                        color: Color(0xff00003D),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusDirectional.circular(20)),
                    content: Column(mainAxisSize: MainAxisSize.min, children: [
                      //
                      const SizedBox(
                        height: 10,
                      ),
                      //
                      _calendar(context),
                      //
                      const SizedBox(
                        height: 20,
                      ),
                      //
                      TextFormField(
                        minLines: 3,
                        keyboardType: TextInputType.multiline,
                        style: const TextStyle(fontSize: 12),
                        maxLines: null,
                        decoration: InputDecorations.calendarInputDecoration(
                          labelText: 'Detalle pedido',
                        ),
                        onChanged: (value) => description,
                      )
                    ]),
                    actions: [
                      _button(context),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      });
}

SizedBox _calendar(BuildContext context) {
  return SizedBox(
    width: double.infinity,
    height: 48,
    child: TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          side: BorderSide(color: Color(0xffB5B5B4)),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
      ),
      onPressed: () {
        _selectDate(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Fecha pedido ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
              style: const TextStyle(color: Color(0xffB5B5B4)),
            ),
            const Icon(
              Icons.calendar_today_outlined,
              color: Color(0xffB5B5B4),
            )
          ],
        ),
      ),
    ),
  );
}

_selectDate(BuildContext context) async {
  final DateTime? selectedN = await showDatePicker(
    context: context,
    initialDate: selectedDate,
    firstDate: DateTime(2022),
    lastDate: DateTime(2025),
  );
  if (selectedN != null && selectedN != selectedDate) selectedDate = selectedN;
}

Container _button(BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(left: 15, right: 15, bottom: 30),
    width: double.infinity,
    height: 45,
    child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: const Color(0xff00003D),
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
        onPressed: () {
          DBProvider.db.agregarOrden(
              selectedDate.toString().split(' ').first, description);
          Navigator.pop(context);
        },
        child: const Text(
          'Aceptar',
          style:
              TextStyle(color: Color(0xFFEFDA30), fontWeight: FontWeight.bold),
        )),
  );
}
