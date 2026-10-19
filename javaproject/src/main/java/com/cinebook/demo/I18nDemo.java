package com.cinebook.demo;

import java.text.DateFormat;
import java.text.NumberFormat;
import java.util.Date;
import java.util.Locale;
import java.util.ResourceBundle;

/**
 * Standalone Internationalization (i18n) and Localization (l10n) Demo
 * Demonstrates ResourceBundle, Locale, Currency, and Date formatting across locales.
 */
public class I18nDemo {

    public static void main(String[] args) {
        System.out.println("==================================================");
        System.out.println("   JAVA INTERNATIONALIZATION (i18n) DEMO          ");
        System.out.println("==================================================");

        Locale[] supportedLocales = new Locale[]{
                new Locale("en", "US"),
                new Locale("es", "ES"),
                new Locale("fr", "FR")
        };

        double ticketPrice = 350.50;
        Date today = new Date();

        for (Locale locale : supportedLocales) {
            System.out.println("\n--------------------------------------------------");
            System.out.println("LOCALE: " + locale.getDisplayName() + " [" + locale + "]");
            System.out.println("--------------------------------------------------");

            try {
                // 1. ResourceBundle translation strings
                ResourceBundle bundle = ResourceBundle.getBundle("messages", locale);

                System.out.println("  App Title       : " + bundle.getString("app.title"));
                System.out.println("  Welcome Message : " + bundle.getString("welcome.message"));
                System.out.println("  Nav Book Now    : " + bundle.getString("btn.booknow"));
                System.out.println("  Seats Label     : " + bundle.getString("label.seats"));
                System.out.println("  Success Message : " + bundle.getString("msg.success"));

                // 2. Localized Currency Formatting
                NumberFormat currencyFormatter = NumberFormat.getCurrencyInstance(locale);
                System.out.println("  Ticket Price    : " + currencyFormatter.format(ticketPrice));

                // 3. Localized Date Formatting
                DateFormat dateFormatter = DateFormat.getDateInstance(DateFormat.FULL, locale);
                System.out.println("  Show Date       : " + dateFormatter.format(today));

            } catch (Exception e) {
                System.err.println("  Error loading bundle for locale " + locale + ": " + e.getMessage());
            }
        }

        System.out.println("\nInternationalization Demo Completed Successfully.");
    }
}
