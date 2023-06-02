import 'package:aplication_salesiana/models/register_student.dart';
import 'package:aplication_salesiana/providers/register_students.dart';
import 'package:aplication_salesiana/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:provider/provider.dart';

// import 'package:vrouter/vrouter.dart';

class RegisterTable extends StatefulWidget {
  final List<ResgisterStudens> registerStudents;
  final int? totalEstudiantes;
  const RegisterTable(
      {super.key, required this.registerStudents, this.totalEstudiantes});

  @override
  State<RegisterTable> createState() => _RegisterTableState();
}

class _RegisterTableState extends State<RegisterTable> {
  // late MedicalProfileProvider _medicalProfileProvider;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // device = Provider.of<ScreenProvider>(context, listen: true).device;
    // _medicalProfileProvider =
    //     Provider.of<MedicalProfileProvider>(context, listen: true);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final List<PlutoColumn> columns = <PlutoColumn>[
      PlutoColumn(
        title: 'Paralelo',
        field: 'paralelo',
        minWidth: 100,
        backgroundColor: Colors.blue,
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        minWidth: 100,
        backgroundColor: Colors.blue,
        title: 'Aula',
        field: 'nro_aula',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        enableDropToResize: true,
        title: 'Docente',
        field: 'docente',
        minWidth: 100,
        backgroundColor: Colors.blue,
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        minWidth: 150,
        title: 'nro_estudiantes',
        field: 'nro_estudiantes',
        backgroundColor: Colors.blue,
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        width: 130,
        title: 'Asistencia D',
        field: 'asistencia',
        backgroundColor: Colors.blue,

        enableEditingMode: false,
        frozen: PlutoColumnFrozen.end,
        type: PlutoColumnType.text(),
        // backgroundColor: AppColors.main,
        enableSorting: false,
        enableContextMenu: false,
        enableFilterMenuItem: false,
        renderer: (PlutoColumnRendererContext rendererContext) {
          return _createActionsButtons(rendererContext, context);
        },
      ),
    ];

    return PlutoGrid(
      columns: columns,
      rows: widget.registerStudents.map((ResgisterStudens regusterStudents) {
        return PlutoRow(cells: {
          'paralelo': PlutoCell(value: regusterStudents.paralelo),
          'nro_aula': PlutoCell(value: regusterStudents.nroAula),
          'docente': PlutoCell(value: regusterStudents.docente),
          'nro_estudiantes': PlutoCell(
              value:
                  widget.totalEstudiantes ?? regusterStudents.nroEstudiantes),
          'asistencia': PlutoCell(value: regusterStudents.asistencia),

          // 'egress_date': PlutoCell(
          //     value: regusterStudents.date == null
          //         ? ''
          //         : CDateFormats.formatDate.format(regusterStudents.date!)),
          // 'registration_number': PlutoCell(value: regusterStudents.registryNumber),
          // 'grade': PlutoCell(value: regusterStudents.grade ?? ''),
          // 'actions': PlutoCell(value: ''),
        });
      }).toList(),
      configuration: PlutoGridConfiguration(
          style: PlutoGridStyleConfig(
        gridBorderRadius: BorderRadius.circular(10),
        borderColor: Colors.blue.shade400,
        gridBorderColor: Colors.blue.shade400,
        gridPopupBorderRadius: BorderRadius.circular(10),
        columnTextStyle: const TextStyle(color: Colors.white),
        iconColor: Colors.white,
      )),
    );
  }

  Row _createActionsButtons(
      PlutoColumnRendererContext rendererContext, BuildContext context) {
    ResgisterStudens registerStudent =
        widget.registerStudents[rendererContext.rowIdx];
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomButton(
            onPressed: () {
              registerStudent.asistencia =
                  !widget.registerStudents[rendererContext.rowIdx].asistencia;
              Provider.of<ResgisterStudensProvider>(context, listen: false)
                  .updateRegister(registerStudent);
              setState(() {});
            },
            text: registerStudent.asistencia ? 'Activo' : 'Desactivo',
            color: registerStudent.asistencia ? Colors.blue : Colors.grey)

        // CustomButtonIcon(
        //     onTap: () {
        //       _medicalProfileProvider.specialtyTable =
        //           widget.specialties[rendererContext.rowIdx];
        //       _medicalProfileProvider.editSpecialty = true;
        //       _medicalProfileProvider.indexSpecialtyTable =
        //           rendererContext.rowIdx;
        //       _medicalProfileProvider.updateScreen();
        //     },
        //     svg: IconGlobal.iconEdit),
        // const SizedBox(width: SizeConstants.margin),
        // CustomButtonIcon(
        //     onTap: () {
        //       Provider.of<MedicalProfileProvider>(context, listen: false)
        //           .removeSpecialty(widget.specialties[rendererContext.rowIdx]);
        //     },
        //     svg: IconGlobal.iconDelete),
      ],
    );
  }
}
