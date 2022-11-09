import 'package:delivery_service/controller/search_controller/search_bloc.dart';
import 'package:delivery_service/controller/search_controller/search_event.dart';
import 'package:delivery_service/model/restaurant_model/vendor_model.dart';
import 'package:delivery_service/ui/widgets/image_loading/image_loading.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchVendorItem extends StatelessWidget {
  final VendorModel vendorModel;

  const SearchVendorItem({required this.vendorModel, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        context.read<SearchBloc>().add(SearchSaveHistoryEvent());
      },
      child: Card(
        color: getCurrentTheme(context).cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ImageLoading(
                imageUrl: vendorModel.image,
                imageWidth: 50,
                imageHeight: 50,
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Text(
                  vendorModel.name,
                  style: getCurrentTheme(context).textTheme.displayMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
