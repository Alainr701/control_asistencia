import 'package:aplication_salesiana/models/register_student.dart';
import 'package:aplication_salesiana/models/usuario.dart';
import 'package:aplication_salesiana/services/auth_methods.dart';
import 'package:aplication_salesiana/services/firestore_affiliates.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResgisterStudensProvider extends ChangeNotifier {
  final FirestoreRegister _scientificEventApi = FirestoreRegister();

  List<ResgisterStudens> _resgisterStudens = [];
  List<ResgisterStudens> get resgisterStudens => _resgisterStudens;
  List<ResgisterStudens> _resgisterStudensTable = [];
  List<ResgisterStudens> get resgisterStudensTable => _resgisterStudensTable;
  bool isLoading = false;

  ResgisterStudensProvider() {}
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

  //update
  Future<bool> updateRegister(ResgisterStudens register) async {
    final result = await _scientificEventApi.updateRegister(register);
    return result;
  }

  //create register table
  Future<bool> createRegisterTable(ResgisterStudens register) async {
    final result = await _scientificEventApi.createRegisterTable(register);
    return result;
  }

  // createRegisterTableForPermanenty
  Future<bool> createRegisterTableForPermanenty(
      ResgisterStudens register) async {
    final result =
        await _scientificEventApi.createRegisterTableForPermanenty(register);
    return result;
  }

  //update
  Future<bool> updateRegisterTable(ResgisterStudens register) async {
    final result = await _scientificEventApi.updateRegisterTable(register);
    return result;
  }

  //get
  Future<List<ResgisterStudens>> getRegisterTable(
      {required String turno,
      required String periodo,
      required String carrera}) async {
    isLoading = true;
    notifyListeners();
    _resgisterStudensTable =
        await _scientificEventApi.getRegisterTable(carrera, turno, periodo);
    isLoading = false;
    notifyListeners();
    return _resgisterStudensTable;
  }
}
