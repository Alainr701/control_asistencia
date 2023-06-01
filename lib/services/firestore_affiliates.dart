import 'dart:developer';

import 'package:aplication_salesiana/models/register_student.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FirestoreRegister {
  final firestore.CollectionReference affiliatesCollection =
      firestore.FirebaseFirestore.instance.collection("registro_alumnos");

  Future<List<ResgisterStudens>> getRegister(String searchText,
      String searchTextTurno, String searchTextPeriodo) async {
    // log("** Getting Affiliate in FirestoreAPI searched type: $searchType, text: $searchText, productsPerPage: $affilatePerPage");
    try {
      List<ResgisterStudens> affiliates = [];
      final firestore.QuerySnapshot snapshot = await affiliatesCollection
          .where('carrera', isEqualTo: searchText)
          .where('turno', isEqualTo: searchTextTurno)
          .where('periodo', isEqualTo: searchTextPeriodo)
          .get();
      affiliates = snapshot.docs
          .map((doc) =>
              ResgisterStudens.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      log("** Success getting **");
      return affiliates;
    } catch (e) {
      log("** Error when getting Affiliate in FirestoreAPI :  $e");
      debugPrint("** Error when getting Affiliate in FirestoreAPI :  $e");
      return [];
    }
  }

  Future<List<ResgisterStudens>> getGenerate(
      String searchText,
      String searchTextTurno,
      String searchTextPeriodo,
      DateTime searchDate) async {
    // log("** Getting Affiliate in FirestoreAPI searched type: $searchType, text: $searchText, productsPerPage: $affilatePerPage");
    try {
      List<ResgisterStudens> affiliates = [];

      // Format the searchDate to only include the date part
      final formattedSearchDate = DateFormat('yyyy-MM-dd').format(searchDate);

      // Construct the start and end timestamps for the search day
      final startTimestamp = DateFormat('yyyy-MM-dd HH:mm:ss')
          .parse('$formattedSearchDate 00:00:00');
      final endTimestamp = DateFormat('yyyy-MM-dd HH:mm:ss')
          .parse('$formattedSearchDate 23:59:59');

      final firestore.QuerySnapshot snapshot = await affiliatesCollection
          .where('carrera', isEqualTo: searchText)
          .where('turno', isEqualTo: searchTextTurno)
          .where('periodo', isEqualTo: searchTextPeriodo)
          // .where('fecha', isEqualTo: firestore.Timestamp.fromDate(searchDate))
          // .where('fecha', isGreaterThanOrEqualTo: startTimestamp)
          // .where('fecha', isLessThanOrEqualTo: endTimestamp)
          .where('fecha',
              isGreaterThanOrEqualTo:
                  firestore.Timestamp.fromDate(startTimestamp))
          .where('fecha',
              isLessThanOrEqualTo: firestore.Timestamp.fromDate(endTimestamp))
          .get();
      affiliates = snapshot.docs
          .map((doc) =>
              ResgisterStudens.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      log("** Success getting **");
      return affiliates;
    } catch (e) {
      log("** Error when getting Affiliate in FirestoreAPI :  $e");
      debugPrint("** Error when getting Affiliate in FirestoreAPI :  $e");
      return [];
    }
  }

  Future<bool> updateParticipant(ResgisterStudens scientificEvent) async {
    log("** Updating a ScientificEvent in FirestoreAPI");
    try {
      firestore.DocumentReference ref =
          affiliatesCollection.doc(scientificEvent.id);
      Map<String, dynamic> group = scientificEvent.toJson();
      log(group.toString());
      await ref.update(group);
      return true;
    } catch (e) {
      log("** Error when upadting a ScientificEvent in FirestoreAPI : $e");
      return false;
    }
  }
}
