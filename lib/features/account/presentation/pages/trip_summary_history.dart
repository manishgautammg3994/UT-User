import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:restart_tagxi/core/utils/custom_button.dart";
import "package:restart_tagxi/features/account/presentation/pages/complaint_list.dart";
import "package:restart_tagxi/features/account/presentation/pages/delivery_proof_view.dart";
import "../../../../common/app_arguments.dart";
import "../../../../common/app_colors.dart";
import "../../../../common/pickup_icon.dart";
import "../../../../core/utils/custom_loader.dart";
import "../../../../core/utils/custom_text.dart";
import "../../../../l10n/app_localizations.dart";
import "../../../bookingpage/presentation/widgets/fare_breakup.dart";
import "../../application/acc_bloc.dart";

class HistoryTripSummaryPage extends StatelessWidget {
  static const String routeName = '/historytripsummary';
  final HistoryPageArguments arg;

  const HistoryTripSummaryPage({super.key, required this.arg});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => AccBloc()
        ..add(AccGetDirectionEvent())
        ..add(ComplaintEvent(complaintType: 'request')),
      child: BlocListener<AccBloc, AccState>(
        listener: (context, state) {
          if (state is AccInitialState) {
            CustomLoader.loader(context);
          }
          if (state is RequestCancelState) {
            Navigator.pop(context);
            Navigator.pop(context);
          }
        },
        child: BlocBuilder<AccBloc, AccState>(builder: (context, state) {
          return Directionality(
              textDirection: context.read<AccBloc>().textDirection == 'rtl'
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              child: Scaffold(
                backgroundColor: Theme.of(context).primaryColor,
                body: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ClipPath(
                          clipper: ShapePainterBottom(),
                          child: Container(
                            padding: EdgeInsets.all(size.width * 0.025),
                            width: size.width,
                            height: size.height * 0.95,
                            color: const Color(0xffDEDCDC),
                            child: ClipPath(
                              clipper: ShapePainterCenter(),
                              child: Container(
                                padding: EdgeInsets.all(size.width * 0.05),
                                width: size.width,
                                height: size.height * 0.5,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: size.width * 0.4,
                                    ),
                                    Row(
                                      children: [
                                        MyText(
                                          text: arg.historyData.requestNumber,
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                color: Theme.of(context)
                                                    .primaryColorDark,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: size.width * 0.02,
                                    ),
                                    Expanded(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: size.width * 0.05,
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(
                                                  size.width * 0.05),
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary
                                                    .withOpacity(0.10),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        width: 50,
                                                        height: 50,
                                                        decoration: BoxDecoration(
                                                            color: Theme.of(
                                                                    context)
                                                                .scaffoldBackgroundColor),
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl: arg
                                                              .historyData
                                                              .vehicleTypeImage,
                                                          fit: BoxFit.fill,
                                                          placeholder:
                                                              (context, url) =>
                                                                  const Center(
                                                            child: Loader(),
                                                          ),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              const Center(
                                                            child: Text(""),
                                                          ),
                                                        ),
                                                      ),
                                                      MyText(
                                                        text: arg.historyData
                                                            .vehicleTypeName,
                                                        textStyle: Theme.of(
                                                                context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .copyWith(
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColorDark),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: size.width * 0.025,
                                                  ),
                                                  Column(
                                                    children: [
                                                      (arg.historyData
                                                                  .isCompleted ==
                                                              1)
                                                          ? Column(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Expanded(
                                                                        child:
                                                                            Row(
                                                                      children: [
                                                                        Icon(
                                                                          Icons
                                                                              .play_arrow,
                                                                          color:
                                                                              Theme.of(context).primaryColorDark,
                                                                        ),
                                                                        MyText(
                                                                          text:
                                                                              AppLocalizations.of(context)!.duration,
                                                                          textStyle: Theme.of(context)
                                                                              .textTheme
                                                                              .bodyMedium!
                                                                              .copyWith(color: Theme.of(context).hintColor),
                                                                        )
                                                                      ],
                                                                    )),
                                                                    MyText(
                                                                      text:
                                                                          '${arg.historyData.totalTime} ${AppLocalizations.of(context)!.mins}',
                                                                      textStyle: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .copyWith(
                                                                              color: Theme.of(context).hintColor),
                                                                    )
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                      size.width *
                                                                          0.025,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Expanded(
                                                                        child:
                                                                            Row(
                                                                      children: [
                                                                        Icon(
                                                                          Icons
                                                                              .play_arrow,
                                                                          color:
                                                                              Theme.of(context).primaryColorDark,
                                                                        ),
                                                                        MyText(
                                                                          text:
                                                                              AppLocalizations.of(context)!.distance,
                                                                          textStyle: Theme.of(context)
                                                                              .textTheme
                                                                              .bodyMedium!
                                                                              .copyWith(color: Theme.of(context).hintColor),
                                                                        )
                                                                      ],
                                                                    )),
                                                                    MyText(
                                                                      text:
                                                                          '${arg.historyData.totalDistance} ${arg.historyData.unit}',
                                                                      textStyle: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .copyWith(
                                                                              color: Theme.of(context).hintColor),
                                                                    )
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                      size.width *
                                                                          0.025,
                                                                ),
                                                              ],
                                                            )
                                                          : const SizedBox(),
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                              child: Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .play_arrow,
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColorDark,
                                                              ),
                                                              MyText(
                                                                text: AppLocalizations.of(
                                                                        context)!
                                                                    .typeofRide,
                                                                textStyle: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyMedium!
                                                                    .copyWith(
                                                                        color: Theme.of(context)
                                                                            .hintColor),
                                                              )
                                                            ],
                                                          )),
                                                          MyText(
                                                            text: (arg.historyData
                                                                        .isRental ==
                                                                    false)
                                                                ? (arg.historyData
                                                                            .isOutStation ==
                                                                        1)
                                                                    ? AppLocalizations.of(
                                                                            context)!
                                                                        .outStation
                                                                    : (arg.historyData.isLater ==
                                                                            true)
                                                                        ? AppLocalizations.of(context)!
                                                                            .rideLater
                                                                        : AppLocalizations.of(context)!
                                                                            .regular
                                                                : 'Rental-${arg.historyData.rentalPackageName}',
                                                            textStyle: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .copyWith(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .hintColor),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            size.width * 0.025,
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.all(
                                                        size.width * 0.020),
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .scaffoldBackgroundColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              2),
                                                      border: Border.all(
                                                        width:
                                                            size.width * 0.001,
                                                        color: Theme.of(context)
                                                            .disabledColor,
                                                      ),
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            const PickupIcon(),
                                                            Expanded(
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        5),
                                                                child: MyText(
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  text: arg
                                                                      .historyData
                                                                      .pickAddress,
                                                                  textStyle: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodySmall,
                                                                ),
                                                              ),
                                                            ),
                                                            MyText(
                                                              text: arg
                                                                  .historyData
                                                                  .cvTripStartTime,
                                                              textStyle: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodySmall!
                                                                  .copyWith(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .disabledColor,
                                                                  ),
                                                            ),
                                                          ],
                                                        ),
                                                        (arg.historyData
                                                                    .dropAddress !=
                                                                "")
                                                            ? Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .symmetric(
                                                                        vertical:
                                                                            5),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceAround,
                                                                  children: [
                                                                    const DropIcon(),
                                                                    Expanded(
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            left:
                                                                                5),
                                                                        child:
                                                                            MyText(
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          text: arg
                                                                              .historyData
                                                                              .dropAddress,
                                                                          textStyle: Theme.of(context)
                                                                              .textTheme
                                                                              .bodySmall,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    MyText(
                                                                      text: arg
                                                                          .historyData
                                                                          .cvCompletedAt,
                                                                      textStyle: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodySmall!
                                                                          .copyWith(
                                                                            color:
                                                                                Theme.of(context).disabledColor,
                                                                          ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              )
                                                            : Container()
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: size.width * 0.04,
                                            ),
                                            // delivery ride
                                            Column(
                                              children: [
                                                if (arg.historyData
                                                            .transportType ==
                                                        'delivery' &&
                                                    arg
                                                        .historyData
                                                        .requestProofs
                                                        .data
                                                        .isNotEmpty)
                                                  Container(
                                                      padding: EdgeInsets.all(
                                                          size.width * 0.05),
                                                      decoration: BoxDecoration(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .secondary
                                                            .withOpacity(0.10),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      child: Column(
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              if (arg
                                                                  .historyData
                                                                  .requestProofs
                                                                  .data
                                                                  .isNotEmpty) {
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder: (context) => DeliveryProofViewPage(
                                                                        images: arg
                                                                            .historyData
                                                                            .requestProofs
                                                                            .data),
                                                                  ),
                                                                );
                                                              }
                                                            },
                                                            child: Row(
                                                              children: [
                                                                const Icon(
                                                                    Icons.image,
                                                                    color: Colors
                                                                        .blue),
                                                                MyText(
                                                                  text: AppLocalizations.of(
                                                                          context)!
                                                                      .loadShipmentProof,
                                                                  textStyle: const TextStyle(
                                                                      color: Colors
                                                                          .blue,
                                                                      decoration:
                                                                          TextDecoration
                                                                              .underline,
                                                                      decorationColor:
                                                                          Colors
                                                                              .blue),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                SizedBox(
                                                  height: size.width * 0.05,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    (arg.historyData
                                                                .isCancelled ==
                                                            1)
                                                        ? MyText(
                                                            text: AppLocalizations
                                                                    .of(context)!
                                                                .cancelled,
                                                            textStyle: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyLarge!
                                                                .copyWith(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .colorScheme
                                                                        .error,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                          )
                                                        : (arg.historyData
                                                                    .isCompleted ==
                                                                1)
                                                            ? MyText(
                                                                text: AppLocalizations.of(
                                                                        context)!
                                                                    .fareBreakup,
                                                                textStyle: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyLarge!
                                                                    .copyWith(
                                                                        color: Theme.of(context)
                                                                            .primaryColorDark,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                              )
                                                            : Container()
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: size.width * 0.025,
                                            ),
                                            (arg.historyData.isBidRide == 1 &&
                                                    arg.historyData
                                                            .isCancelled ==
                                                        0)
                                                ? Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          SizedBox(
                                                            height: size.width *
                                                                0.025,
                                                          ),
                                                          MyText(
                                                              text: (arg.historyData
                                                                          .paymentOpt ==
                                                                      '1')
                                                                  ? AppLocalizations.of(
                                                                          context)!
                                                                      .cash
                                                                  : (arg.historyData.paymentOpt ==
                                                                          '2')
                                                                      ? AppLocalizations.of(context)!
                                                                          .wallet
                                                                      : (arg.historyData.paymentOpt ==
                                                                              '0')
                                                                          ? AppLocalizations.of(context)!
                                                                              .card
                                                                          : '',
                                                              textStyle: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .displayLarge!
                                                                  .copyWith(
                                                                      color: Theme.of(context)
                                                                          .primaryColorDark)),
                                                          (arg.historyData
                                                                      .requestBill ==
                                                                  null)
                                                              ? MyText(
                                                                  text: (arg.historyData.isBidRide ==
                                                                          1)
                                                                      ? '${arg.historyData.requestedCurrencySymbol} ${arg.historyData.acceptedRideFare}'
                                                                      : (arg.historyData.isCompleted ==
                                                                              1)
                                                                          ? '${arg.historyData.requestBill.data.requestedCurrencySymbol} ${arg.historyData.requestBill.data.totalAmount}'
                                                                          : '${arg.historyData.requestedCurrencySymbol} ${arg.historyData.requestEtaAmount}')
                                                              : MyText(
                                                                  text:
                                                                      '${arg.historyData.requestBill.data.requestedCurrencySymbol} ${arg.historyData.requestBill.data.totalAmount}',
                                                                  textStyle: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .displayLarge)
                                                        ],
                                                      ),
                                                    ],
                                                  )
                                                : (arg.historyData
                                                            .isCancelled ==
                                                        1)
                                                    ? const SizedBox()
                                                    : (arg.historyData
                                                                .requestBill !=
                                                            null)
                                                        ? Column(
                                                            children: [
                                                              if (arg
                                                                      .historyData
                                                                      .requestBill
                                                                      .data
                                                                      .basePrice !=
                                                                  0)
                                                                FareBreakup(
                                                                    text: AppLocalizations.of(
                                                                            context)!
                                                                        .basePrice,
                                                                    price:
                                                                        '${arg.historyData.requestBill.data.requestedCurrencySymbol} ${arg.historyData.requestBill.data.basePrice}'),
                                                              if (arg
                                                                      .historyData
                                                                      .requestBill
                                                                      .data
                                                                      .distancePrice !=
                                                                  0)
                                                                FareBreakup(
                                                                    text: AppLocalizations.of(
                                                                            context)!
                                                                        .distancePrice,
                                                                    price:
                                                                        '${arg.historyData.requestBill.data.requestedCurrencySymbol} ${arg.historyData.requestBill.data.distancePrice}'),
                                                              if (arg
                                                                      .historyData
                                                                      .requestBill
                                                                      .data
                                                                      .timePrice !=
                                                                  0)
                                                                FareBreakup(
                                                                    text: AppLocalizations.of(
                                                                            context)!
                                                                        .timePrice,
                                                                    price:
                                                                        '${arg.historyData.requestBill.data.requestedCurrencySymbol} ${arg.historyData.requestBill.data.timePrice}'),
                                                              if (arg
                                                                      .historyData
                                                                      .requestBill
                                                                      .data
                                                                      .waitingCharge !=
                                                                  0)
                                                                FareBreakup(
                                                                    text: AppLocalizations.of(
                                                                            context)!
                                                                        .waitingPrice,
                                                                    price:
                                                                        '${arg.historyData.requestBill.data.requestedCurrencySymbol} ${arg.historyData.requestBill.data.waitingCharge}'),
                                                              if (arg
                                                                      .historyData
                                                                      .requestBill
                                                                      .data
                                                                      .adminCommision !=
                                                                  0)
                                                                FareBreakup(
                                                                    text: AppLocalizations.of(
                                                                            context)!
                                                                        .convenienceFee,
                                                                    price:
                                                                        '${arg.historyData.requestBill.data.requestedCurrencySymbol} ${arg.historyData.requestBill.data.adminCommision}'),
                                                              if (arg
                                                                      .historyData
                                                                      .requestBill
                                                                      .data
                                                                      .promoDiscount !=
                                                                  0)
                                                                FareBreakup(
                                                                  text: AppLocalizations.of(
                                                                          context)!
                                                                      .discount,
                                                                  price:
                                                                      '${arg.historyData.requestBill.data.requestedCurrencySymbol} ${arg.historyData.requestBill.data.promoDiscount}',
                                                                  textcolor: Theme.of(
                                                                          context)
                                                                      .primaryColorDark,
                                                                  pricecolor: Theme.of(
                                                                          context)
                                                                      .primaryColorDark,
                                                                ),
                                                              FareBreakup(
                                                                  text: AppLocalizations.of(
                                                                          context)!
                                                                      .taxes,
                                                                  price:
                                                                      '${arg.historyData.requestBill.data.requestedCurrencySymbol} ${arg.historyData.requestBill.data.serviceTax}'),
                                                            ],
                                                          )
                                                        : Container(),
                                            SizedBox(
                                              height: size.width * 0.025,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    (arg.historyData.requestBill != null &&
                                            arg.historyData.isBidRide != 1)
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Row(
                                                  children: [
                                                    MyText(
                                                      text: (arg.historyData
                                                                  .paymentOpt ==
                                                              '1')
                                                          ? AppLocalizations.of(
                                                                  context)!
                                                              .cash
                                                          : (arg.historyData
                                                                      .paymentOpt ==
                                                                  '2')
                                                              ? AppLocalizations
                                                                      .of(
                                                                          context)!
                                                                  .wallet
                                                              : (arg.historyData
                                                                          .paymentOpt ==
                                                                      '0')
                                                                  ? AppLocalizations.of(
                                                                          context)!
                                                                      .card
                                                                  : '',
                                                      textStyle: Theme.of(
                                                              context)
                                                          .textTheme
                                                          .bodyLarge!
                                                          .copyWith(
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColorDark,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                    ),
                                                    SizedBox(
                                                      width: size.width * 0.025,
                                                    ),
                                                    (arg.historyData
                                                                .requestBill ==
                                                            null)
                                                        ? MyText(
                                                            text: (arg.historyData
                                                                        .isBidRide ==
                                                                    1)
                                                                ? '${arg.historyData.requestBill.data.requestedCurrencySymbol} ${arg.historyData.requestBill.data.acceptedRideFare}'
                                                                : (arg.historyData
                                                                            .isCompleted ==
                                                                        1)
                                                                    ? '${arg.historyData.requestBill.data.requestedCurrencySymbol} ${arg.historyData.requestBill.data.totalAmount}'
                                                                    : '${arg.historyData.requestBill.data.requestedCurrencySymbol} ${arg.historyData.requestBill.data.requestEtaAmount}',
                                                            textStyle: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize: size
                                                                            .width *
                                                                        0.045),
                                                          )
                                                        : MyText(
                                                            text:
                                                                '${arg.historyData.requestBill.data.requestedCurrencySymbol} ${arg.historyData.requestBill.data.totalAmount}',
                                                            textStyle: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize: size
                                                                            .width *
                                                                        0.045)),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: size.width * 0.02,
                                              ),
                                            ],
                                          )
                                        : const SizedBox(),
                                    (arg.historyData.isCompleted == 1)
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, top: 10),
                                            child: CustomButton(
                                                buttonName: AppLocalizations.of(
                                                        context)!
                                                    .makeComplaint,
                                                onTap: () {
                                                  Navigator.pushNamed(
                                                      context,
                                                      ComplaintListPage
                                                          .routeName,
                                                      arguments:
                                                          ComplaintListPageArguments(
                                                              choosenHistoryId: arg
                                                                  .historyData
                                                                  .id
                                                                  .toString()));
                                                }),
                                          )
                                        : (arg.historyData.isLater &&
                                                arg.historyData.isCancelled ==
                                                    0)
                                            ? CustomButton(
                                                buttonName: AppLocalizations.of(
                                                        context)!
                                                    .cancel,
                                                buttonColor: Theme.of(context)
                                                    .primaryColor,
                                                onTap: () {
                                                  showModalBottomSheet(
                                                      context: context,
                                                      isScrollControlled: false,
                                                      enableDrag: false,
                                                      isDismissible: true,
                                                      builder: (_) {
                                                        return cancelRide(
                                                            context, size);
                                                      });
                                                })
                                            : Container(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (arg.historyData.driverDetail != null)
                      (arg.historyData.isCancelled == 1)
                          ? const SizedBox()
                          : Positioned(
                              top: 100,
                              child: SizedBox(
                                width: size.width,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: size.width * 0.8,
                                      child: MyText(
                                        text: arg
                                            .historyData.driverDetail.data.name,
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                              color: AppColors.whiteText,
                                            ),
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                      ),
                                    ),
                                    SizedBox(
                                      height: size.width * 0.025,
                                    ),
                                    Container(
                                      height: size.width * 0.2,
                                      width: size.width * 0.2,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                      ),
                                      child: ClipOval(
                                        child: CachedNetworkImage(
                                          imageUrl: arg.historyData.driverDetail
                                              .data.profilePicture,
                                          fit: BoxFit.fill,
                                          placeholder: (context, url) =>
                                              const Center(
                                            child: Loader(),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Center(
                                            child: Text(""),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )),
                    Positioned(
                        child: SafeArea(
                      child: Column(
                        children: [
                          SizedBox(
                            width: size.width * 0.20,
                          ),
                          Container(
                            height: size.height * 0.08,
                            width: size.width * 0.08,
                            decoration: const BoxDecoration(
                              color: AppColors.whiteText,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(5.0, 5.0),
                                  blurRadius: 10.0,
                                  spreadRadius: 2.0,
                                ),
                              ],
                            ),
                            child: IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(
                                CupertinoIcons.back,
                                size: 20,
                                color: AppColors.blackText,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.width * 0.05,
                          ),
                        ],
                      ),
                    )),
                  ],
                ),
              ));
        }),
      ),
    );
  }

  Widget cancelRide(BuildContext context, Size size) {
    return StatefulBuilder(builder: (_, add) {
      return Container(
        padding: MediaQuery.of(context).viewInsets,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(size.width * 0.05),
                topRight: Radius.circular(size.width * 0.05))),
        width: size.width,
        child: Container(
          padding: EdgeInsets.all(size.width * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              MyText(
                text: AppLocalizations.of(context)!.rideLaterCancelText,
                textStyle: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.w600),
                maxLines: 2,
              ),
              SizedBox(
                height: size.width * 0.05,
              ),
              CustomButton(
                  width: size.width * 0.5,
                  buttonName: AppLocalizations.of(context)!.cancel,
                  onTap: () {
                    context.read<AccBloc>().add(
                          RideLaterCancelRequestEvent(
                              requestId: arg.historyData.id),
                        );
                  }),
            ],
          ),
        ),
      );
    });
  }
}

class ShapePainterBottom extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height * 0.35);
    path.quadraticBezierTo(size.width * 0.985, size.height * 0.25,
        size.width * 0.8, size.height * 0.225);
    path.lineTo(size.width * 0.15, size.height * 0.13);
    path.quadraticBezierTo(size.width * 0, size.height * 0.1, 0, 0);
    path.lineTo(0, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class ShapePainterCenter extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, size.height * 0.125);
    path.lineTo(0, size.height - 20);
    path.quadraticBezierTo(0, size.height, 20, size.height);
    path.lineTo(size.width - 20, size.height);
    path.quadraticBezierTo(
        size.width, size.height, size.width, size.height - 20);
    path.lineTo(size.width * 0.99, size.height * 0.335);
    path.quadraticBezierTo(size.width * 0.965, size.height * 0.25,
        size.width * 0.8, size.height * 0.23);
    path.lineTo(10, size.height * 0.123);
    path.quadraticBezierTo(size.width * 0.0, size.height * 0.12,
        size.width * 0.0, size.height * 0.14);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
