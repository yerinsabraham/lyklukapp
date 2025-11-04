import '../../../../core/shared/resources/typedefs.dart';
import '../../model/carrier_model.dart';

abstract class  LogisticsRepository{
  //  get available carriers
  FutureResponse<List<CarrierModel>> getAvailableCarriers ({required Map<String, dynamic> query});

}