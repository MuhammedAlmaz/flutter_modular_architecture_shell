import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

abstract class AppBlocRepository<BlocCallModel, BlocStoreModel> {
  BlocCallModel? _requestObject;
  bool _isBlocHandling = false;
  BlocStoreModel? _store;
  BlocStoreModel? Function()? _initialStore;
  Function? onSuccess;
  Function? onError;

  final PublishSubject<BlocStoreModel?> _fetcher = PublishSubject<BlocStoreModel?>();
  final Uuid _uuidGenerator = const Uuid();
  String _lastRequestUniqueId = "";
  Function(BlocStoreModel?)? _listener;

  PublishSubject<BlocStoreModel?> get fetcher => _fetcher;

  Stream<BlocStoreModel?> get stream => _fetcher.stream;

  BlocStoreModel? get store => _store;

  // String get lastRequestUniqueId => this._lastRequestUniqueId;

  bool get isBlocHandling => _isBlocHandling;

  String get lastRequestUniqueId => _lastRequestUniqueId;

  BlocCallModel? get requestObject => _requestObject;

  OmwoBlocRepository({BlocStoreModel? Function()? initialStore}) {
    if (initialStore != null) {
      _store = initialStore();
      _initialStore = initialStore;
    }
  }

  void reGenerate() {
    if (_initialStore != null) {
      _store = _initialStore!();
    } else {
      _store = null;
    }
    _requestObject = null;
    _isBlocHandling = false;
    notifyState();
  }

  void setStore(BlocStoreModel? store) => _store = store;

  void clearBlocCallModel() => _requestObject = null;

  void clearStore() {
    _store = null;
    fetcher.sink.add(null);
  }

  Future _prevProcess() async {
    try {
      _lastRequestUniqueId = _uuidGenerator.v4();
      await process(_lastRequestUniqueId);
      _isBlocHandling = false;
    } catch (err, stacktrace) {
      print(err);
      print(stacktrace);
      _isBlocHandling = false;
      notifyState();
    }
  }

  Future process(String lastRequestUniqueId);

  Future<Null> call({BlocCallModel? callObject, bool sinkNullObject = false, Function? onSuccess, Function? onError, bool clearStorageBeforeCall = false}) async {
    if (clearStorageBeforeCall) _store = null;
    _isBlocHandling = true;
    _requestObject = callObject;
    this.onSuccess = onSuccess;
    this.onError = onError;
    if (sinkNullObject) fetcher.sink.add(null);
    await _prevProcess();
    if (!_isBlocHandling) {
      _isBlocHandling = false;
      notifyState();
    }
  }

  @protected
  setBlocHandling({required bool isBlocHandling}) {
    _isBlocHandling = isBlocHandling;
    fetcher.sink.add(_store);
  }

  void notifyState() {
    fetcher.sink.add(null);
  }

  void fetcherSink(BlocStoreModel? nextStoreObject, {bool forceSink = false, required lastRequestUniqueId}) {
    if (forceSink || lastRequestUniqueId == _lastRequestUniqueId) {
      _store = nextStoreObject;
      fetcher.sink.add(nextStoreObject);
      if (_listener != null) _listener!(nextStoreObject);
    } else {
//      print("this request is old request" + BlocStoreModel.toString());
    }
  }

  dispose() {
    _fetcher.close();
  }
}
