import 'package:aplication_salesiana/models/register_student.dart';
import 'package:aplication_salesiana/services/firestore_affiliates.dart';
import 'package:flutter/material.dart';

class ResgisterStudensProvider extends ChangeNotifier {
  final FirestoreRegister _scientificEventApi = FirestoreRegister();

  List<ResgisterStudens> _resgisterStudens = [];
  List<ResgisterStudens> get resgisterStudens => _resgisterStudens;
  bool isLoading = false;
  Future<void> getRegisters(
      {required String turno,
      required String periodo,
      required String carrera}) async {
    isLoading = true;
    notifyListeners();
    _resgisterStudens =
        await _scientificEventApi.getRegister(carrera, turno, periodo);
    isLoading = false;
    notifyListeners();
  }

  Future<List<ResgisterStudens>> generateRegister(
      {required String turno,
      required String periodo,
      required String carrera,
      required DateTime fecha}) async {
    isLoading = true;
    notifyListeners();
    _resgisterStudens =
        await _scientificEventApi.getGenerate(carrera, turno, periodo, fecha);
    isLoading = false;
    notifyListeners();
    return _resgisterStudens;
  }

  Future<bool> updateRegisters(ResgisterStudens participant) async {
    final result = await _scientificEventApi.updateParticipant(participant);
    return result;
  }
}
