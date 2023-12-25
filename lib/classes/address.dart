class Address {
  late String _cep;
  late String _logradouro;
  late String _complemento;
  late String _bairro;
  late String _localidade;
  late String _uf;
  late String? _ibge;
  late String? _gia;
  late String? _ddd;
  late String? _siafi;

  Address({
    required String cep,
    required String logradouro,
    required String complemento,
    required String bairro,
    required String localidade,
    required String uf,
    String? ibge,
    String? gia,
    String? ddd,
    String? siafi,
  })  : _siafi = siafi,
        _ddd = ddd,
        _gia = gia,
        _ibge = ibge,
        _uf = uf,
        _localidade = localidade,
        _bairro = bairro,
        _logradouro = logradouro,
        _complemento = complemento,
        _cep = cep;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        cep: json['cep'],
        logradouro: json['logradouro'],
        complemento: json['complemento'],
        bairro: json['bairro'],
        localidade: json['localidade'],
        uf: json['uf'],
        ibge: json['ibge'],
        gia: json['gia'],
        ddd: json['ddd'],
        siafi: json['siafi'],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'cep': _cep,
        'logradouro': _logradouro,
        'complemento': _complemento,
        'bairro': _bairro,
        'localidade': _localidade,
        'uf': _uf,
        'ibge': _ibge,
        'gia': _gia,
        'ddd': _ddd,
        'siafi': _siafi
      };

  factory Address.empty() => Address(
        cep: '',
        logradouro: '',
        complemento: '',
        bairro: '',
        localidade: '',
        uf: '',
        ibge: '',
        gia: '',
        ddd: '',
        siafi: '',
      );

  String get cep => _cep;
  String get logradouro => _logradouro;
  String get complemento => _complemento;
  String get bairro => _bairro;
  String get localidade => _localidade;
  String get uf => _uf;
  String? get ibge => _ibge;
  String? get gia => _gia;
  String? get ddd => _ddd;
  String? get siafi => _siafi;

  bool isEmpty() {
    return _cep.isEmpty &&
        _logradouro.isEmpty &&
        _complemento.isEmpty &&
        _bairro.isEmpty &&
        _localidade.isEmpty &&
        _uf.isEmpty &&
        (_ibge == null || _ibge!.isEmpty) &&
        (_gia == null || _gia!.isEmpty) &&
        (_ddd == null || _ddd!.isEmpty) &&
        (_siafi == null || _siafi!.isEmpty);
  }

  @override
  String toString() => toJson().toString();
}
