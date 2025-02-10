import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:techtest_guia_motel/models/motel_model.dart';
import 'package:techtest_guia_motel/models/suite_model.dart';
import 'package:techtest_guia_motel/models/period_model.dart';
import 'package:techtest_guia_motel/services/moteis.dart';

// Mock classes
class MockMotelServices extends Mock implements MotelServices {}

void main() {
  group('MotelModel Tests', () {
    test('MotelModel fromJson creates correct object', () {
      final json = {
        'fantasia': 'Test Motel',
        'logo': 'logo_url',
        'bairro': 'Test Neighborhood',
        'distancia': 5.5,
        'qtdFavoritos': 10,
        'suites': [],
        'qtdAvaliacoes': 100,
        'media': 4.5
      };

      final motel = MotelModel.fromJson(json);

      expect(motel.name, 'Test Motel');
      expect(motel.logoUrl, 'logo_url');
      expect(motel.neighborhood, 'Test Neighborhood');
      expect(motel.distance, 5.5);
      expect(motel.favorites, 10);
      expect(motel.reviews, 100);
      expect(motel.rate, 4.5);
    });
  });

  group('SuiteModel Tests', () {
    test('SuiteModel fromJson creates correct object', () {
      final json = {
        'nome': 'Test Suite',
        'qtd': 5,
        'exibirQtdDisponiveis': true,
        'fotos': ['photo1', 'photo2'],
        'itens': [
          {'nome': 'Item 1'},
          {'nome': 'Item 2'}
        ],
        'categoriaItens': [
          {'nome': 'Hidro', 'icone': 'hidro_icon'},
          {'nome': 'Piscina', 'icone': 'piscina_icon'}
        ],
        'periodos': [
          {
            'tempoFormatado': '3 horas',
            'tempo': '3',
            'valor': 100.0,
            'valorTotal': 100.0,
            'temCortesia': false,
            'desconto': null
          }
        ]
      };

      final suite = SuiteModel.fromJson(json);

      expect(suite.name, 'Test Suite');
      expect(suite.quantity, 5);
      expect(suite.showAvailability, true);
      expect(suite.photos, ['photo1', 'photo2']);
      expect(suite.items!.length, 2);
      expect(suite.categoryItems!.length, 2);
      expect(suite.periods!.length, 1);
    });
  });

  group('PeriodModel Tests', () {
    test('PeriodModel fromJson handles discount correctly', () {
      final json = {
        'tempoFormatado': '3 horas',
        'tempo': '3',
        'valor': 100.0,
        'valorTotal': 100.0,
        'temCortesia': false,
        'desconto': {'desconto': 20.0}
      };

      final period = PeriodModel.fromJson(json);

      expect(period.formattedTime, '3 horas');
      expect(period.price, 100.0);
      expect(period.discount, 20.0);
    });
  });

  group('Motel Filtering Tests', () {
    test('Filter motels with discounts', () {
      final motel1 = MotelModel(suites: [
        SuiteModel(
            periods: [PeriodModel(discount: 10.0), PeriodModel(discount: null)])
      ]);
      final motel2 = MotelModel(suites: [
        SuiteModel(periods: [PeriodModel(discount: null)])
      ]);

      final discountMotels = [motel1, motel2]
          .where((motel) => motel.suites!.any((suite) => suite.periods!.any(
              (period) => period.discount != null && period.discount! > 0)))
          .toList();

      expect(discountMotels.length, 1);
      expect(discountMotels.first, motel1);
    });

    test('Filter motels with available suites', () {
      final motel1 = MotelModel(
          suites: [SuiteModel(quantity: 5), SuiteModel(quantity: 0)]);
      final motel2 = MotelModel(suites: [SuiteModel(quantity: 0)]);

      final availableMotels = [motel1, motel2]
          .where((motel) => motel.suites!
              .any((suite) => suite.quantity != null && suite.quantity! > 0))
          .toList();

      expect(availableMotels.length, 1);
      expect(availableMotels.first, motel1);
    });
  });
}
