import 'package:aplication_salesiana/models/register_student.dart';
import 'package:pdf/pdf.dart';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart';
import 'dart:html';
import 'dart:io' as io;
import 'dart:typed_data';

class PdfWebService {
  static downloadPdf(Uint8List pdfData, String filename) {
    var blob = Blob([pdfData.buffer.asUint8List()], 'application/pdf');
    var link = document.createElement('a') as AnchorElement;
    link.href = Url.createObjectUrl(blob);
    link.download = '${filename}CV.pdf';
    document.body!.append(link);
    link.click();
    link.remove();
  }
}

class PdfTemplates {
  static double titleSize = 15.0;
  static double bigTitleSize = 17.0;
  static double regularSize = 10.0;
  static double smallSize = 8.0;
  static Future<Uint8List> affiliationDocPdf(
      {required String turno,
      required String periodo,
      required String carrera,
      required DateTime fecha,
      required List<ResgisterStudens> resgisterStudens}) async {
    // DateTime now = DateTime.now();
    final pdf = Document();
    // final imageData =
    //     (await rootBundle.load('assets/images/logo.png')).buffer.asUint8List();
    // final image = MemoryImage(imageData);
    // Add a page to the document
    pdf.addPage(MultiPage(
        pageFormat: PdfPageFormat.a4,
        maxPages: 1,
        margin: const EdgeInsets.only(left: 30, top: 20, right: 20),
        build: (Context context) {
          return <Widget>[
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    // Image(image, height: 80, width: 80),
                    SizedBox(width: 10),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('UNIVERSIDAD',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: bigTitleSize),
                                  textAlign: TextAlign.center),
                              Text("SALESIANA DE BOLIVIA",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: titleSize),
                                  textAlign: TextAlign.center),
                              Text("CONTROL DE ASISTENCIA",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: regularSize),
                                  textAlign: TextAlign.center),
                            ]),
                      ),
                    ),
                  ]),
                  SizedBox(height: 20),
                ]),
            SizedBox(height: 5),
            Row(children: [
              Text("Carrera: $carrera",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: regularSize),
                  textAlign: TextAlign.center),
              Spacer(),
              Text("Fecha: ${fecha.day}/${fecha.month}/${fecha.year}",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: regularSize),
                  textAlign: TextAlign.center),
            ]),
            SizedBox(height: 5),
            Text("Turno: $turno",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: regularSize),
                textAlign: TextAlign.center),
            SizedBox(height: 5),
            Text("Periodo: $periodo",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: regularSize),
                textAlign: TextAlign.center),
            SizedBox(height: 5),
            _createWorkplacesPdf(resgisterStudens),
            SizedBox(height: 5),
            // Text("OBSERVACIONES:",
            //     style: TextStyle(
            //         fontWeight: FontWeight.bold, fontSize: regularSize),
            //     textAlign: TextAlign.center),
            SizedBox(height: 5),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('JUAN JAVIER GUILLÉN',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: regularSize)),
                        Text('RESPONSABLE DE AFILIACIÓN',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: smallSize))
                      ]),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            width: 150,
                            height: 80,
                            decoration:
                                BoxDecoration(border: Border.all(width: 2))),
                        Text('FIRMA',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: regularSize)),
                      ]),
                ]),
          ];
        })); // Page

    return pdf.save();
  }

  static Widget _createWorkplacesPdf(List<ResgisterStudens> resgisterStudens) {
    List<TableRow> rows = [];
    rows.add(
      TableRow(children: [
        Padding(
            padding: const EdgeInsets.all(10 / 2),
            child: Text("Paralelo",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: regularSize))),
        Padding(
            padding: const EdgeInsets.all(10 / 2),
            child: Text("Aula",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: regularSize))),
        Padding(
            padding: const EdgeInsets.all(10 / 2),
            child: Text("Docente",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: regularSize))),
        Padding(
            padding: const EdgeInsets.all(10 / 2),
            child: Text("Nro. Estudiantes",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: regularSize))),
        Padding(
            padding: const EdgeInsets.all(10 / 2),
            child: Text("Asistencia",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: regularSize))),
      ], decoration: BoxDecoration(color: PdfColor.fromHex("#F2F2F2"))),
    );
    for (int index = 0; index < resgisterStudens.length; index++) {
      rows.add(TableRow(children: [
        Padding(
            padding: const EdgeInsets.all(4),
            child: SizedBox(
                width: PdfPageFormat.letter.width * 0.2,
                child: Text(resgisterStudens[index].paralelo,
                    style: TextStyle(fontSize: regularSize),
                    textAlign: TextAlign.center))),
        Padding(
            padding: const EdgeInsets.all(4),
            child: SizedBox(
                width: PdfPageFormat.letter.width * 0.2,
                child: Text(resgisterStudens[index].nroAula,
                    style: TextStyle(fontSize: regularSize),
                    textAlign: TextAlign.center))),
        Padding(
            padding: const EdgeInsets.all(4),
            child: SizedBox(
                width: PdfPageFormat.letter.width * 0.2,
                child: Text(resgisterStudens[index].docente,
                    style: TextStyle(fontSize: regularSize),
                    textAlign: TextAlign.center))),
        Padding(
            padding: const EdgeInsets.all(4),
            child: SizedBox(
                width: PdfPageFormat.letter.width * 0.2,
                child: Text(resgisterStudens[index].nroEstudiantes.toString(),
                    style: TextStyle(fontSize: regularSize),
                    textAlign: TextAlign.center))),
        Padding(
          padding: const EdgeInsets.all(4),
          child: Container(
            width: 15,
            height: 15,
            decoration: BoxDecoration(
                color: resgisterStudens[index].asistencia
                    ? PdfColor.fromHex("#00FF00")
                    : PdfColor.fromHex("#FF0000"),
                border: Border.all(width: 1),
                borderRadius: BorderRadius.circular(5)),
          ),
        ),
      ]));
    }
    Table table = Table(children: rows, border: TableBorder.all());
    return table;
  }
}
