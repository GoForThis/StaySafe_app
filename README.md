# StaySafe
Aplikacja do monitorowania zagrożeń w swojej okolicy na terenie całej Polski. Bazę zagrożeń w czasie rzeczywistym, tworzą użytkownicy. Aplikacja będzie pozwalała unikać zagrożeń w życiu codziennym oraz planować powroty np. do domu w nocy przez miasto.



# Technologie
Flutter, Firebase(?), ASP.Net Core, GoogleMaps SDK for Android,

# Obsługiwane urządzenia:
•	IoS
•	Android
•	Przeglądarka(?)

Planowany ruch: Jak największy – podstawa działania aplikacji – Co najmniej 500 na 500tys+ miasto


# Przypadki użycia:
1.	Użytkownik widzi zagrożenie (bójka, protest, niebezpieczna grupa ludzi, miejsce które warto pomijać z różnych przyczyn), otwiera aplikację, klika zgłoś zagrożenie wybierając jego rodzaj. Maksymalnie 4 kliknięcia
2.	Użytkownik nie używając aplikacji, dostaje komunikat – W pobliżu, Xmetrów stąd, na ulicy XY, doszło to Y zagrożenia.
3.	Użytkownik będzie wracał do domu w środku nocy gdzie ma kilka możliwości dróg. Wchodzi do aplikacji i widzi, że na jednej z nich, zgłoszone jest 1h temu, że kręci się grupa pijanych ludzi. Uzytkownik wybiera inną, bezpieczniejszą drogę.
4.	Użytkownik wstaje rano wybiera się do pracy. Wchodzi na aplikację i okazuje się, że Prezydent USA przyjechał do Warszawy i pół miasta jest zablokowane. Użytkownik wychodzi wcześniej żeby pójść inną drogą.


# Specyfikacja funkcjonalna
1.	Rejestracja użytkownika: 
Aplikacja powinna umożliwiać użytkownikom rejestrację i logowanie się do konta. Rejestracja może być przeprowadzona za pomocą adresu e-mail lub konta zewnętrznego, takiego jak konto Google.
2.	Tworzenie i przeglądanie bazy zagrożeń:
Aplikacja powinna umożliwiać użytkownikom przeglądanie bazy zagrożeń zgłoszonych przez innych użytkowników. Użytkownicy powinni również mieć możliwość zgłaszania nowych zagrożeń, takich jak kradzieże, napady, napaści itp.
3.	Mapa zagrożeń: 
Aplikacja powinna wyświetlać mapę zagrożeń, na której użytkownicy mogą zobaczyć lokalizacje zgłoszonych zagrożeń w ich okolicy.
4.	Powiadomienia o zagrożeniach: 
Aplikacja powinna umożliwiać użytkownikom otrzymywanie powiadomień o zagrożeniach w ich okolicy na podstawie ich bieżącej lokalizacji. Użytkownicy powinni mieć możliwość wyboru, jakie powiadomienia chcą otrzymywać.
5.	Planowanie tras: Aplikacja powinna umożliwiać użytkownikom planowanie tras, które pomogą uniknąć miejsc zarejestrowanych w bazie zagrożeń. Użytkownicy powinni mieć możliwość wyboru optymalnej trasy lub alternatywnej trasy.
6.	Forma aplikacji: Możliwość włączenia „prostego” widoku – bez mapy, sama okrojona lista, prosty przejrzysty wygląd – dla osób starszych/niepełnosprawnych

# Specyfikacja niefunkcjonalna:
•	Obsługi klienta:
Brak - zwykłe Q&A
•	Monitorowanie:
Statystyki z danych dzielnic lub miejszych rejonów
•	Kolorystyka: 
1 kolor jasno-zielony, drugi obojętny
•	Interfejs użytkownika:
Aplikacja powinna mieć intuicyjny i łatwy w obsłudze interfejs użytkownika, który będzie dostępny w języku polskim.
•	Dostępność: 
Aplikacja powinna być dostępna na smartfonach z systemem iOS i Android.



# MVP:

Tworzenie i przeglądanie bazy zagrożeń:
Aplikacja powinna umożliwiać użytkownikom przeglądanie bazy zagrożeń zgłoszonych przez innych użytkowników. Użytkownicy powinni również mieć możliwość zgłaszania nowych zagrożeń, takich jak kradzieże, napady, napaści itp.
Mapa zagrożeń: 
Aplikacja powinna wyświetlać mapę zagrożeń, na której użytkownicy mogą zobaczyć lokalizacje zgłoszonych zagrożeń w ich okolicy.
Powiadomienia o zagrożeniach: 
Aplikacja powinna umożliwiać użytkownikom otrzymywanie powiadomień o zagrożeniach w ich okolicy na podstawie ich bieżącej lokalizacji. Użytkownicy powinni mieć możliwość wyboru, jakie powiadomienia chcą otrzymywać.

