import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tabibi_2/app/core/app_colors.dart';
import 'package:tabibi_2/app/core/style_constants.dart';
import 'package:tabibi_2/app/core/styles.dart';
import 'package:tabibi_2/app/providers/city_doctor_provider.dart';
import 'package:tabibi_2/generated/l10n.dart';
import 'package:tabibi_2/widgets/card_f.dart';
import 'package:tabibi_2/widgets/card_introdaction.dart';
import 'package:provider/provider.dart';

class JoneScreen extends StatefulWidget {
  const JoneScreen({super.key});

  @override
  State<JoneScreen> createState() => _JoneScreenState();
}

class _JoneScreenState extends State<JoneScreen> {
  final PageController _pageController = PageController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController doctorController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch cities and doctors when the screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CityDoctorProvider>(context, listen: false).fetchCities();
      Provider.of<CityDoctorProvider>(context, listen: false).fetchDoctors();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    cityController.dispose();
    doctorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const CardImageAndProFile(),
                const SizedBox(height: AppSize.s16),
                Consumer<CityDoctorProvider>(builder: (context, provider, _) {
                  return Column(children: [
                    TextFormField(
                      controller: cityController,
                      decoration: InputDecoration(
                        hintText: S.of(context).searchCity,
                        hintStyle: getRegularStyle(
                          fontSize: FontSize.s16,
                          color: AppColors.textSecondaryColor,
                        ),
                        suffixIcon: provider.citiesStatus == DataStatus.loading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child:
                                    CircularProgressIndicator(strokeWidth: 2),
                              )
                            : null,
                      ),
                      onChanged: (value) {
                        provider.searchCities(value);
                      },
                    ),
                    if (cityController.text.isNotEmpty &&
                        provider.filteredCities.isNotEmpty)
                      Container(
                        constraints: const BoxConstraints(maxHeight: 200),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: provider.filteredCities.length,
                          itemBuilder: (context, index) {
                            final city = provider.filteredCities[index];
                            return ListTile(
                              title: Text(city.name),
                              subtitle: Text(city.country),
                              onTap: () {
                                cityController.text = city.name;
                                provider.setSelectedCity(city);
                                provider.filterDoctorsByCity(city.name);
                                FocusScope.of(context).unfocus();
                              },
                            );
                          },
                        ),
                      ),
                    const SizedBox(height: AppSize.s16),
                    TextFormField(
                      controller: doctorController,
                      decoration: InputDecoration(
                        hintText: S.of(context).searchDoctor,
                        hintStyle: getRegularStyle(
                          fontSize: FontSize.s16,
                          color: AppColors.textSecondaryColor,
                        ),
                        suffixIcon: provider.doctorsStatus == DataStatus.loading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child:
                                    CircularProgressIndicator(strokeWidth: 2),
                              )
                            : null,
                      ),
                      onChanged: (value) {
                        provider.searchDoctors(value);
                      },
                    ),
                    if (doctorController.text.isNotEmpty &&
                        provider.filteredDoctors.isNotEmpty)
                      Container(
                        constraints: const BoxConstraints(maxHeight: 200),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: provider.filteredDoctors.length,
                          itemBuilder: (context, index) {
                            final doctor = provider.filteredDoctors[index];
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(doctor.imageUrl),
                                onBackgroundImageError: (_, __) {},
                              ),
                              title: Text(doctor.name),
                              subtitle:
                                  Text('${doctor.specialty} • ${doctor.city}'),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.star,
                                      color: Colors.amber, size: 16),
                                  Text(doctor.rating.toString()),
                                ],
                              ),
                              onTap: () {
                                doctorController.text = doctor.name;
                                FocusScope.of(context).unfocus();
                                // Navigate to doctor details or handle selection
                              },
                            );
                          },
                        ),
                      ),
                  ]);
                }),
                const SizedBox(height: AppSize.s16),
                const SizedBox(height: AppSize.s16),
                Consumer<CityDoctorProvider>(builder: (context, provider, _) {
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (provider.cityError.isNotEmpty ||
                            provider.doctorError.isNotEmpty)
                          Container(
                            padding: const EdgeInsets.all(8),
                            margin: const EdgeInsets.only(bottom: 8),
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              provider.cityError.isNotEmpty
                                  ? provider.cityError
                                  : provider.doctorError,
                              style: getRegularStyle(
                                fontSize: FontSize.s14,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ElevatedButton(
                          onPressed: () {
                            // Navigate to signup screen
                            Navigator.pushNamed(context, '/signUp');
                          },
                          child: Text(S.of(context).signUp),
                        ),
                      ]);
                }),
                const SizedBox(height: AppSize.s16),
                SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: PageView(
                    controller: _pageController,
                    children: const [
                      CardIntrodaction(),
                      CardIntrodaction(),
                      CardIntrodaction(),
                    ],
                  ),
                ),
                const SizedBox(height: AppSize.s10),
                Center(
                  child: SmoothPageIndicator(
                    controller: _pageController,
                    count: 3,
                    effect: const WormEffect(
                      activeDotColor: AppColors.primaryColor,
                      dotHeight: 10,
                      dotWidth: 10,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).categories,
                      style: getSemiBoldStyle(
                        fontSize: FontSize.s16,
                        color: AppColors.textPrimaryColor,
                      ),
                    ),
                    Text(
                      S.of(context).seeAll,
                      style: getRegularStyle(
                        fontSize: FontSize.s12,
                        color: AppColors.textSecondaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

