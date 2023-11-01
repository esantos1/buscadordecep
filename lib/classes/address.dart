class Address {
  final String _cep;
  final String _logradouro;
  final String _complemento;
  final String _bairro;
  final String _localidade;
  final String _uf;
  final String? _ibge;
  final String? _gia;
  final String? _ddd;
  final String? _siafi;

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

  @override
  String toString() {
    return toJson().toString();
  }
}
