
# Uygulama Tanıtımı - IOS

https://github.com/user-attachments/assets/ae10b384-b266-46d1-864d-56ec6635a916

 # Uygulama Tanıtımı - ANDROID


https://github.com/user-attachments/assets/8792c136-f6e9-49d5-9c49-16d923f13ff9


<br>
<br>



# Mimari Yapı
```
lib/
├── main.dart                            # Uygulama giriş noktası
│
├── core/                                # Genel (tekrar kullanılabilir) altyapı bileşenleri
│   ├── di/                              # Dependency Injection (bağımlılık yönetimi)
│   ├── extension/                       # Dart uzantıları (extension methods)
│   ├── cache/                           # SharedPreferences yönetimi
│   ├── theme/                           # Temaya dair yardımcılar
│   └── constans/                        # Uygulama bağımsız genel sabitleri
│
├── product/                             # Ürün bazlı katman (özelleştirilmiş servisler, enumlar, tema cubit'i)
│   ├── enums/                           # Uygulamaya bağımlı enumlar
│   ├── theme/                           # Uygulamaya bağımlı tema servisi
│   ├── constans/                        # Uygulamaya bağımlı sabitler
│   └── data/                            # Veriye erişim (örnek: route_repo)
│
├── feature/                             # Feature (özellik) tabanlı yapı
│   └── home/                            # Home sayfası için MVVM
│       ├── cubit(viewModel)/            # Cubit iş yönetimi
│       ├── view/                        # sayfaya ait tasarımlar,widgetlar
│       └── model/                       # home ait modeller
│   └── splash/
```


1. core/ – Tüm proje genelinde tekrar kullanılabilecek soyut yapılar<br>


🔹 di/
di.dart → Dependency Injection yapılandırması (GetIt, injectable, vs.)

🔹 extension/
Uygulamaya özel String, BuildContext, vs. uzantılar (extension) içerir.

🔹 cache/
locale_manager.dart → SharedPreferences ile verilerin lokal olarak saklanmasını sağlar.

🔹 theme/
theme.dart → Uygulamanın varsayılan ThemeData yapılandırması.

🔹 constans/
app_constants.dart → Uygulama genelinde kullanılan sabit değerler (baseUrl, timeout, vs.)


<br>

2. feature/ – özellik bazlı katman(sayfalar)<br>

🔹 view/
home_view.dart → viewe ait öğeler

🔹 model/
model.dart → kullanılan modeller

🔹 cubit(ViewModel)/
cubit.dart → sayfada yapılacak iş akışları gerçekleştirilir.

<br>



3. product/ – Uygulamaya Özgü Yapılar<br>


🔹 enums/
preferences_types.dart → Cache veya ayarlarda kullanılan enum tanımları.

🔹 theme/
theme_cubit.dart → Uygulamanın açık/koyu tema yönetimi yapılır.

🔹 constans/
product_constants.dart → Feature’lara özel sabitler.

🔹 data/
route_repo.dart → Lokasyon ve rota verilerini yöneten repository sınıfı. Harici servislerle buradan iletişim kurulur.

<br>
<br>

# Kurulum
Bu projeyi çalıştırmak için aşağıdaki adımları takip edebilirsiniz:

Depoyu Klonlama:<br>
git clone https://github.com/RamazanAksoy/marti_case_ra.git

Gerekli Paketleri Yükleme: Projenin bağımlılıklarını yüklemek için aşağıdaki komutu çalıştırın<br>
flutter pub get

Uygulamayı Çalıştırma: Uygulamayı çalıştırmak için şu komutu kullanabilirsiniz<br>
flutter run

