import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/values/app_colors.dart';
import '../controllers/dashboard_controller.dart';
import 'widgets/banner_slider.dart';
import 'widgets/category_grid.dart';
import 'widgets/live_price_bar.dart';
import 'widgets/offer_banner.dart';
import 'package:jewel_ecom/app/controllers/theme_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => scaffoldKey.currentState?.openDrawer(),
          icon: Icon(
            Icons.menu_rounded,
            color: Theme.of(context).colorScheme.onSurface,
            size: 28,
          ),
        ),
        title: Text(
          "JEWEL E-COM",
          style: TextStyle(
            color: AppColors.primary,
            letterSpacing: 4,
            fontWeight: FontWeight.w300,
            fontSize: 20,
            fontFamily:
                'Playfair Display', // Assuming a premium font is available or fallback
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search_rounded,
              color: Theme.of(context).colorScheme.onSurface,
              size: 24,
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.notifications_none_rounded,
                  color: Theme.of(context).colorScheme.onSurface,
                  size: 24,
                ),
              ),
              Positioned(
                right: 12,
                top: 12,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isDark ? Colors.black : Colors.white,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      drawer: _buildDrawer(context),
      body: Obx(() {
        switch (controller.tabIndex.value) {
          case 0:
            return _buildHome(context);
          default:
            return Center(
              child: Text(
                "Feature Coming Soon",
                style: TextStyle(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.5),
                ),
              ),
            );
        }
      }),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildHome(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const SizedBox(height: 10),
          const BannerSlider(),
          const SizedBox(height: 20),
          const LivePriceBar(),
          const OfferBanner(),
          Obx(
            () => CategoryGrid(
              categories: controller.categories,
              isLoading: controller.isLoadingCategories.value,
            ),
          ),

          // Featured Section
          _buildSectionHeader(context, "New Arrivals"),
          const SizedBox(height: 12),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: 5,
              itemBuilder: (context, index) {
                return _buildProductCard(context);
              },
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              "View All",
              style: TextStyle(color: AppColors.primary, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF121212) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.05)
              : Colors.black.withValues(alpha: 0.05),
        ),
        boxShadow: isDark
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                image: const DecorationImage(
                  image: NetworkImage(
                    "https://images.unsplash.com/photo-1605100804763-247f67b3557e?q=80&w=2070&auto=format&fit=crop",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Diamond Ring",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 12,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  "₹45,000",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          // Premium Header
          _buildDrawerHeader(context),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDrawerSectionTitle(context, "SHOP"),
                  _buildDrawerItem(
                    context,
                    icon: Icons.grid_view_rounded,
                    title: "All Collections",
                    onTap: () {},
                  ),
                  _buildDrawerItem(
                    context,
                    icon: Icons.auto_awesome_rounded,
                    title: "New Arrivals",
                    onTap: () {},
                  ),
                  _buildDrawerItem(
                    context,
                    icon: Icons.workspace_premium_rounded,
                    title: "Best Sellers",
                    onTap: () {},
                  ),

                  _buildDrawerDivider(context),
                  _buildDrawerSectionTitle(context, "ACCOUNT"),
                  _buildDrawerItem(
                    context,
                    icon: Icons.person_outline_rounded,
                    title: "My Profile",
                    onTap: () {},
                  ),
                  _buildDrawerItem(
                    context,
                    icon: Icons.shopping_bag_outlined,
                    title: "My Orders",
                    onTap: () {},
                  ),
                  _buildDrawerItem(
                    context,
                    icon: Icons.favorite_border_rounded,
                    title: "Wishlist",
                    onTap: () {},
                  ),
                  _buildDrawerItem(
                    context,
                    icon: Icons.location_on_outlined,
                    title: "Manage Address",
                    onTap: () {},
                  ),

                  _buildDrawerDivider(context),
                  _buildDrawerSectionTitle(context, "SETTINGS"),
                  _buildThemeToggle(context),

                  _buildDrawerDivider(context),
                  _buildDrawerSectionTitle(context, "SUPPORT"),
                  _buildDrawerItem(
                    context,
                    icon: Icons.help_outline_rounded,
                    title: "Help Center",
                    onTap: () {},
                  ),
                  _buildDrawerItem(
                    context,
                    icon: Icons.info_outline_rounded,
                    title: "About Us",
                    onTap: () {},
                  ),
                  _buildDrawerItem(
                    context,
                    icon: Icons.policy_outlined,
                    title: "Privacy Policy",
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),

          // Footer
          _buildDrawerFooter(context),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.only(top: 60, left: 24, right: 24, bottom: 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isDark
              ? [const Color(0xFF1A1A1A), const Color(0xFF0F0F0F)]
              : [const Color(0xFFFFFFFF), const Color(0xFFF5F5F5)],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.5 : 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary,
                      AppColors.primary.withValues(alpha: 0.5),
                    ],
                  ),
                ),
                child: CircleAvatar(
                  radius: 32,
                  backgroundColor: isDark ? Colors.black : Colors.white,
                  child: Text(
                    controller.userName.value.isNotEmpty
                        ? controller.userName.value[0].toUpperCase()
                        : "U",
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 26,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => Text(
                        controller.userName.value,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Obx(
                      () => Text(
                        controller.userEmail.value,
                        style: TextStyle(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.4),
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: () {},
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "VIEW PROFILE",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.arrow_right_alt_rounded,
                  color: AppColors.primary,
                  size: 16,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerDivider(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Divider(color: Theme.of(context).dividerTheme.color, thickness: 1),
    );
  }

  Widget _buildDrawerSectionTitle(BuildContext context, String title) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(left: 24, top: 16, bottom: 8),
      child: Text(
        title,
        style: TextStyle(
          color: AppColors.primary.withValues(alpha: isDark ? 0.6 : 0.9),
          fontSize: 10,
          fontWeight: FontWeight.w900,
          letterSpacing: 2.5,
        ),
      ),
    );
  }

  Widget _buildThemeToggle(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    return Obx(
      () => ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 24),
        leading: Icon(
          themeController.isDarkMode.value
              ? Icons.dark_mode_rounded
              : Icons.light_mode_rounded,
          color: AppColors.primary.withValues(alpha: 0.7),
          size: 22,
        ),
        title: Text(
          "Appearance",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        trailing: SizedBox(
          width: 50,
          height: 24,
          child: Switch(
            value: themeController.isDarkMode.value,
            onChanged: (value) => themeController.toggleTheme(),
            activeThumbColor: AppColors.primary,
            activeTrackColor: AppColors.primary.withValues(alpha: 0.2),
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? color,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
      leading: Icon(
        icon,
        color:
            color ??
            Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
        size: 22,
      ),
      title: Text(
        title,
        style: TextStyle(
          color:
              color ??
              Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.9),
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right_rounded,
        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.2),
        size: 18,
      ),
    );
  }

  Widget _buildDrawerFooter(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 40),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF121212) : const Color(0xFFF5F5F5),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.05),
            blurRadius: 20,
            offset: const Offset(0, -10),
          ),
        ],
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Get.back();
              controller.logout();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.redAccent.withValues(alpha: 0.2),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.logout_rounded,
                    color: Colors.redAccent.withValues(alpha: 0.8),
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "LOGOUT SESSION",
                    style: TextStyle(
                      color: Colors.redAccent.withValues(alpha: 0.8),
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialIcon(context, Icons.facebook),
              const SizedBox(width: 25),
              _buildSocialIcon(context, Icons.camera_alt_outlined),
              const SizedBox(width: 25),
              _buildSocialIcon(context, Icons.language),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            "JEWEL E-COM • VERSION 1.0.0",
            style: TextStyle(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.2),
              fontSize: 9,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(BuildContext context, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.05),
      ),
      child: Icon(
        icon,
        color: AppColors.primary.withValues(alpha: 0.4),
        size: 18,
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.05),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Theme.of(
            context,
          ).colorScheme.onSurface.withValues(alpha: 0.3),
          selectedItemColor: AppColors.primary,
          showUnselectedLabels: true,
          unselectedLabelStyle: const TextStyle(fontSize: 10),
          selectedLabelStyle: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
          onTap: controller.changeTabIndex,
          currentIndex: controller.tabIndex.value,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'HOME',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.grid_view_outlined),
              activeIcon: Icon(Icons.grid_view),
              label: 'COLLECTION',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined),
              activeIcon: Icon(Icons.shopping_bag),
              label: 'CART',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'PROFILE',
            ),
          ],
        ),
      ),
    );
  }
}
