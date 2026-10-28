import '../models/curriculum_day.dart';

class CurriculumData {
  static List<CurriculumDay> getFullCurriculum() {
    return [
      // ==========================================
      // PHASE 1: الأساسيات والتفكير البرمجي (Week 1-2)
      // ==========================================
      CurriculumDay(
        dayNumber: 1,
        phaseId: 1,
        phaseTitle: 'المرحلة 1: التأسيس البرمجي وعلوم الحاسب',
        phaseBadge: 'الأساسيات (14 يوم)',
        title: 'كيف يعمل الحاسوب وما هي البرمجة؟',
        description: 'فهم البنية الأساسية للكمبيوتر (CPU, RAM, Storage) وكيف تُترجم الأكواد إلى لغة الآلة، ومعنى الخوارزمية.',
        fourHourStudyGoals: [
          'الساعة 1: فهم آلية عمل المعالج والذاكرة المؤقتة والدائمة، والنظام الثنائي (Binary System).',
          'الساعة 2: دور لغات البرمجة (High-Level vs Low-Level) ودور المترجم (Compiler vs Interpreter).',
          'الساعة 3: مدخل إلى المنطق البرمجي: الشروط (Conditions)، التكرار (Loops)، والمتغيرات (Variables).',
          'الساعة 4: التفكير كمهندس برمجيات: تحليل المشاكل وتقسيمها إلى خطوات أصغر (Decomposition).',
        ],
        oneHourPracticeGoal: 'حل 3 ألغاز منطقية على الورق، ورسم خريطة تدفق (Flowchart) لبرنامج آلة حاسبة بسيطة.',
        links: [
          LessonLink(
            title: 'كورس مقدمة في علوم الحاسب - الزيرو',
            url: 'https://www.youtube.com/playlist?list=PLDoPjvoNmBAw_t_XWUFbBX-c9MafPk9ji',
            sourceName: 'Elzero Web School',
          ),
          LessonLink(
            title: 'ما هي لغات البرمجة وكيف تعمل؟ - وائل أبو حمزة',
            url: 'https://www.youtube.com/results?search_query=how+programming+works+arabic',
            sourceName: 'شرح بالعربي',
          ),
        ],
      ),
      CurriculumDay(
        dayNumber: 2,
        phaseId: 1,
        phaseTitle: 'المرحلة 1: التأسيس البرمجي وعلوم الحاسب',
        phaseBadge: 'الأساسيات (14 يوم)',
        title: 'الخوارزميات وخرائط التدفق (Flowcharts)',
        description: 'تعلم التفكير الخوارزمي قبل كتابة سطر كود واحد، وكيفية رسم مخطط سير العمليات.',
        fourHourStudyGoals: [
          'الساعة 1: الرموز القياسية لخرائط التدفق (Start, Input, Decision, Process, Output).',
          'الساعة 2: تطبيق الخرائط على خوارزميات شهيرة (إيجاد العدد الأكبر، فحص العدد الزوجي والفردي).',
          'الساعة 3: كتابة الـ Pseudocode (الكود الزائف) لتحويل الفكرة إلى منطق برمجي.',
          'الساعة 4: حساب التعقيد الزمني والمكاني ببساطة (مفهوم الـ Efficiency).',
        ],
        oneHourPracticeGoal: 'استخدام أداة Draw.io لرسم خريطة تدفق لعملية تسجيل دخول مستخدم بالتحقق من كلمة المرور.',
        links: [
          LessonLink(
            title: 'شرح الخوارزميات ومخططات الانسياب للمبتدئين',
            url: 'https://www.youtube.com/results?search_query=algorithms+flowcharts+for+beginners+arabic',
            sourceName: 'YouTube Tutorials',
          ),
          LessonLink(
            title: 'أداة رسم المخططات المجانية Draw.io',
            url: 'https://app.diagrams.net/',
            sourceName: 'Tools',
            type: 'exercise',
          ),
        ],
      ),
      CurriculumDay(
        dayNumber: 3,
        phaseId: 1,
        phaseTitle: 'المرحلة 1: التأسيس البرمجي وعلوم الحاسب',
        phaseBadge: 'الأساسيات (14 يوم)',
        title: 'إتقان الـ Terminal ونظام إدارة النسخ Git',
        description: 'التعامل مع سطر الأوامر وأساسيات Git لحفظ الأكواد والرجوع لأي نقطة زمنية.',
        fourHourStudyGoals: [
          'الساعة 1: أهم أوامر التيرمينال (cd, ls/dir, mkdir, rm, touch/ni) والتنقل بين المسارات.',
          'الساعة 2: ما هو Git ولماذا لا يستغني عنه أي مبرمج، وتثبيت Git وضبط الاسم والإيميل.',
          'الساعة 3: دورة حياة الملفات في Git: (Working -> Staging -> Repository). أركان: init, status, add, commit.',
          'الساعة 4: استخدام git log, git diff والتراجع عن التغييرات باستخدام git restore و git reset.',
        ],
        oneHourPracticeGoal: 'إنشاء مجلد عبر التيرمينال، تفعيل Git فيه، عمل 3 ملفات مع 3 commits متتالية، واستعراض الـ log.',
        links: [
          LessonLink(
            title: 'دورة Git & GitHub كاملة - الزيرو',
            url: 'https://www.youtube.com/playlist?list=PLDoPjvoNmBAw4eOj58MZPakHjaO3frVMF',
            sourceName: 'Elzero Web School',
          ),
          LessonLink(
            title: 'Git Documentation & Cheat Sheet',
            url: 'https://git-scm.com/doc',
            sourceName: 'Official Docs',
            type: 'doc',
          ),
        ],
      ),
      CurriculumDay(
        dayNumber: 4,
        phaseId: 1,
        phaseTitle: 'المرحلة 1: التأسيس البرمجي وعلوم الحاسب',
        phaseBadge: 'الأساسيات (14 يوم)',
        title: 'منصة GitHub وإدارة المشاريع البرمجية',
        description: 'ربط المستودع المحلي بالإنترنت على GitHub، الفروع (Branches)، والـ Pull Requests.',
        fourHourStudyGoals: [
          'الساعة 1: إنشاء حساب GitHub، توليد مفاتيح SSH أو Personal Access Tokens.',
          'الساعة 2: أوامر الرفع والربط: git remote add origin, git push -u origin main, git pull.',
          'الساعة 3: مفهوم الـ Branching (الفروع): git checkout -b feature, git merge, وحل الـ Conflicts.',
          'الساعة 4: إنشاء Pull Request على GitHub وكتابة ملف README.md احترافي.',
        ],
        oneHourPracticeGoal: 'رفع مشروع تدريبي كامل على GitHub مع ملف README منسق بالمارك داون يحتوي على صور ووصف.',
        links: [
          LessonLink(
            title: 'كورس Git & GitHub الدرس 15-25: الفروع والرفع',
            url: 'https://www.youtube.com/playlist?list=PLDoPjvoNmBAw4eOj58MZPakHjaO3frVMF',
            sourceName: 'Elzero Web School',
          ),
        ],
      ),

      // ==========================================
      // PHASE 2: PHP & MySQL (Backend Basics)
      // ==========================================
      CurriculumDay(
        dayNumber: 5,
        phaseId: 2,
        phaseTitle: 'المرحلة 2: لغة PHP وقواعد البيانات MySQL',
        phaseBadge: 'باك إند وقواعد بيانات (21 يوم)',
        title: 'تثبيت البيئة وأساسيات لغة PHP 8+',
        description: 'تثبيت XAMPP أو Laragon وتشغيل أول خادم ويب محلي، وتعلم المتغيرات وأنواع البيانات في PHP.',
        fourHourStudyGoals: [
          'الساعة 1: تثبيت Laragon/XAMPP، معرفة ماهية خادم Apache وفلسفة Client-Server.',
          'الساعة 2: كتابة أول كود PHP، المتغيرات (\$variable)، وقواعد التسمية والتعليقات.',
          'الساعة 3: أنواع البيانات (Data Types): String, Integer, Float, Boolean, Array, Null.',
          'الساعة 4: المعاملات الحسابية والمقارنة والمنطقية (Operators) وكيفية التحقق من الأنواع var_dump.',
        ],
        oneHourPracticeGoal: 'كتابة سكربت لحساب فاتورة منتجات مع تطبيق خصم وضريبة وطباعة الناتج منسقاً.',
        links: [
          LessonLink(
            title: 'دورة لغة PHP 8 كاملة - أسامة الزيرو',
            url: 'https://www.youtube.com/playlist?list=PLDoPjvoNmBAzH72MTPuAAaYfReraNlQgM',
            sourceName: 'Elzero Web School',
          ),
          LessonLink(
            title: 'PHP Official Documentation',
            url: 'https://www.php.net/manual/en/',
            sourceName: 'Official Docs',
            type: 'doc',
          ),
        ],
      ),
      CurriculumDay(
        dayNumber: 6,
        phaseId: 2,
        phaseTitle: 'المرحلة 2: لغة PHP وقواعد البيانات MySQL',
        phaseBadge: 'باك إند وقواعد بيانات (21 يوم)',
        title: 'الشروط وحلقات التكرار والمصفوفات في PHP',
        description: 'التحكم في سير البرنامج باستخدام if-else, switch, match وحلقات for, foreach والمصفوفات المترابطة.',
        fourHourStudyGoals: [
          'الساعة 1: الجمل الشرطية المتقدمة، التعبير الثلاثي (Ternary Operator) وميزة Match في PHP 8.',
          'الساعة 2: المصفوفات الرقمية (Indexed Arrays) والمصفوفات المترابطة (Associative Arrays) ومتعددة الأبعاد.',
          'الساعة 3: حلقات التكرار (while, do-while, for, foreach) والمرور على المصفوفات.',
          'الساعة 4: دوال المصفوفات الأساسية: array_merge, array_keys, in_array, array_filter.',
        ],
        oneHourPracticeGoal: 'بناء مصفوفة قائمة طلاب بدرجاتهم، ثم فرز الناجحين واستخراج المتوسط الحسابي عبر حلقة تكرار.',
        links: [
          LessonLink(
            title: 'شرح المصفوفات والتكرار في PHP - الزيرو',
            url: 'https://www.youtube.com/playlist?list=PLDoPjvoNmBAzH72MTPuAAaYfReraNlQgM',
            sourceName: 'Elzero Web School',
          ),
        ],
      ),
      CurriculumDay(
        dayNumber: 7,
        phaseId: 2,
        phaseTitle: 'المرحلة 2: لغة PHP وقواعد البيانات MySQL',
        phaseBadge: 'باك إند وقواعد بيانات (21 يوم)',
        title: 'الدوال (Functions) وإعادة الاستخدام في PHP',
        description: 'إنشاء دوال مخصصة، تمرير المعاملات بالقيمة وبالمرجع، والدوال المجهولة ونطاق المتغيرات.',
        fourHourStudyGoals: [
          'الساعة 1: بناء الدوال وتحديد نوع المخرجات والمعاملات (Type Hinting).',
          'الساعة 2: المعاملات الافتراضية، Named Arguments وميزة Variable Arguments (...\$args).',
          'الساعة 3: نطاق المتغيرات (Variable Scope): global, local, static.',
          'الساعة 4: الدوال المجهولة (Anonymous Functions) و Arrow Functions.',
        ],
        oneHourPracticeGoal: 'بناء مكتبة دوال مساعدة (Validation Helpers) للتحقق من صحة الإيميل ورقم الهاتف وكلمة المرور.',
        links: [
          LessonLink(
            title: 'الدوال في PHP بالتفصيل - الزيرو',
            url: 'https://www.youtube.com/playlist?list=PLDoPjvoNmBAzH72MTPuAAaYfReraNlQgM',
            sourceName: 'Elzero Web School',
          ),
        ],
      ),
      CurriculumDay(
        dayNumber: 8,
        phaseId: 2,
        phaseTitle: 'المرحلة 2: لغة PHP وقواعد البيانات MySQL',
        phaseBadge: 'باك إند وقواعد بيانات (21 يوم)',
        title: 'البرمجة كائنية التوجه (OOP) في PHP - الجزء الأول',
        description: 'فهم الركائز الأساسية للكائنات: الفئات، الخصائص، الدوال، والمنشئ Constructor.',
        fourHourStudyGoals: [
          'الساعة 1: لماذا نحتاج OOP؟ مفهوم Class مقابل Object وأمثلة واقعية من الحياة اليومية.',
          'الساعة 2: الخصائص والدوال (Properties & Methods) واستخدام الكلمة المفتاحية \$this.',
          'الساعة 3: المنشئ والدامس (__construct & __destruct) و Property Promotion في PHP 8.',
          'الساعة 4: معدلات الوصول والتغليف (Encapsulation): public, private, protected ودوال Getters & Setters.',
        ],
        oneHourPracticeGoal: 'بناء فئة User وفئة BankAccount تدير الرصيد والسحب والإيداع مع حماية الرصيد كـ Private.',
        links: [
          LessonLink(
            title: 'دورة PHP OOP كاملة - الزيرو',
            url: 'https://www.youtube.com/playlist?list=PLDoPjvoNmBAyX71uh7m4-EttP3ODscda3',
            sourceName: 'Elzero Web School',
          ),
        ],
      ),
      CurriculumDay(
        dayNumber: 9,
        phaseId: 2,
        phaseTitle: 'المرحلة 2: لغة PHP وقواعد البيانات MySQL',
        phaseBadge: 'باك إند وقواعد بيانات (21 يوم)',
        title: 'البرمجة كائنية التوجه (OOP) - الجزء الثاني: الوراثة والواجهات',
        description: 'الوراثة (Inheritance)، الفئات المجردة (Abstract)، الواجهات (Interfaces)، والـ Traits.',
        fourHourStudyGoals: [
          'الساعة 1: الوراثة (extends) وإعادة تعريف الدوال (Method Overriding) واستخدام parent::.',
          'الساعة 2: الفئات المجردة (Abstract Classes) وتطبيق العقود الإلزامية.',
          'الساعة 3: الواجهات (Interfaces) وتعدد الأشكال (Polymorphism) والفارق بين Interface و Abstract Class.',
          'الساعة 4: الخصائص المشتركة (Traits) لتجاوز قيود الوراثة الأحادية في PHP، واستخدام Namespaces.',
        ],
        oneHourPracticeGoal: 'بناء نظام دفع إلكتروني يعتمد على Interface PaymentGateway وتطبيقات لـ Stripe و PayPal و Fawry.',
        links: [
          LessonLink(
            title: 'OOP Interfaces & Polymorphism - الزيرو',
            url: 'https://www.youtube.com/playlist?list=PLDoPjvoNmBAyX71uh7m4-EttP3ODscda3',
            sourceName: 'Elzero Web School',
          ),
        ],
      ),
      CurriculumDay(
        dayNumber: 10,
        phaseId: 2,
        phaseTitle: 'المرحلة 2: لغة PHP وقواعد البيانات MySQL',
        phaseBadge: 'باك إند وقواعد بيانات (21 يوم)',
        title: 'تصميم قواعد البيانات العلائقية ولغة SQL',
        description: 'مفاهيم قواعد البيانات، الجداول، المفاتيح (Primary & Foreign Key)، والاستعلامات الأساسية.',
        fourHourStudyGoals: [
          'الساعة 1: ما هي قواعد البيانات العلائقية (RDBMS)، وتثبيت واستخدام phpMyAdmin أو TablePlus.',
          'الساعة 2: إنشاء الجداول وتحديد أنواع الحقول (VARCHAR, INT, TEXT, TIMESTAMP).',
          'الساعة 3: عمليات CRUD بلغة SQL: (INSERT INTO, SELECT WHERE, UPDATE, DELETE).',
          'الساعة 4: العلاقات بين الجداول (1-to-1, 1-to-Many, Many-to-Many) وكتابة استعلامات الربط (JOINs).',
        ],
        oneHourPracticeGoal: 'تصميم مخطط قاعدة بيانات متجر إلكتروني (Users, Categories, Products, Orders) وكتابة كود الـ SQL لإنشائها.',
        links: [
          LessonLink(
            title: 'دورة MySQL كاملة - الزيرو',
            url: 'https://www.youtube.com/playlist?list=PLDoPjvoNmBAz6DT8SzQ1CODJTH-NIA7R9',
            sourceName: 'Elzero Web School',
          ),
        ],
      ),
      CurriculumDay(
        dayNumber: 11,
        phaseId: 2,
        phaseTitle: 'المرحلة 2: لغة PHP وقواعد البيانات MySQL',
        phaseBadge: 'باك إند وقواعد بيانات (21 يوم)',
        title: 'الربط الآمن بين PHP و MySQL عبر PDO',
        description: 'استخدام كائن PDO للاتصال بقاعدة البيانات وحماية التطبيق من هجمات SQL Injection.',
        fourHourStudyGoals: [
          'الساعة 1: الاتصال بقاعدة البيانات باستخدام PDO وإدارة استثناءات الاتصال try-catch.',
          'الساعة 2: فهم هجمات حقن قواعد البيانات (SQL Injection) وكيفية منعها كلياً.',
          'الساعة 3: تنفيذ الاستعلامات المحضرة (Prepared Statements) وربط المعاملات (Binding Parameters).',
          'الساعة 4: جلب البيانات بأنماط مختلفة (fetch, fetchAll, PDO::FETCH_ASSOC, FETCH_OBJ).',
        ],
        oneHourPracticeGoal: 'بناء تطبيق Todo List كامل بـ PHP و PDO يحفظ المهام في جدول MySQL مع عمليات الإضافة والتعديل والحذف.',
        links: [
          LessonLink(
            title: 'شرح PDO والاتصال الآمن بقواعد البيانات - الزيرو',
            url: 'https://www.youtube.com/results?search_query=elzero+php+pdo',
            sourceName: 'Elzero Web School',
          ),
        ],
      ),

      // ==========================================
      // PHASE 3: Laravel Framework & REST APIs
      // ==========================================
      CurriculumDay(
        dayNumber: 12,
        phaseId: 3,
        phaseTitle: 'المرحلة 3: إطار العمل Laravel وبناء REST APIs',
        phaseBadge: 'إتقان لارفيل والـ APIs (28 يوم)',
        title: 'تثبيت Laravel، مدير الحزم Composer، وتوزيع المجلدات',
        description: 'تثبيت Composer وإنشاء أول مشروع Laravel، والتعرف على بنية MVC ومسارات Routing.',
        fourHourStudyGoals: [
          'الساعة 1: ما هو Composer وما دوره في نظام بيئة PHP، وكيفية إنشاء مشروع: composer create-project laravel/laravel.',
          'الساعة 2: فهم معمارية MVC (Model - View - Controller) وسير الطلب (Request Lifecycle).',
          'الساعة 3: التوجيه الأساسي (Basic Routing): routes/web.php و routes/api.php، وتمرير المعاملات Route Parameters.',
          'الساعة 4: خادم التطوير php artisan serve وأهم أوامر سطر أوامر Artisan.',
        ],
        oneHourPracticeGoal: 'تجهيز مشروع لارفيل جديد وإنشاء 5 مسارات مختلفة ترجع نصوصاً وبيانات JSON مع تسمية المسارات (Named Routes).',
        links: [
          LessonLink(
            title: 'دورة لارفيل Laravel كاملة للمبتدئين - وائل أبو حمزة',
            url: 'https://www.youtube.com/playlist?list=PL93xoG4309c488_Ocs_Wk_N6Z2Z6F6d9r',
            sourceName: 'Wael Abo Hamza',
          ),
          LessonLink(
            title: 'Laravel 11 Documentation',
            url: 'https://laravel.com/docs',
            sourceName: 'Official Docs',
            type: 'doc',
          ),
        ],
      ),
      CurriculumDay(
        dayNumber: 13,
        phaseId: 3,
        phaseTitle: 'المرحلة 3: إطار العمل Laravel وبناء REST APIs',
        phaseBadge: 'إتقان لارفيل والـ APIs (28 يوم)',
        title: 'المتحكمات (Controllers) ونظام القوالب Blade',
        description: 'إنشاء Controllers لتنظيم منطق العمل، وربطها بصفحات العرض Blade ونظام التوريث.',
        fourHourStudyGoals: [
          'الساعة 1: إنشاء Controllers باستخدام Artisan: php artisan make:controller.',
          'الساعة 2: دورة حياة الطلب واستقبال البيانات عبر Request Object.',
          'الساعة 3: أساسيات محرك القوالب Blade: التوجيهات (@if, @foreach, @empty, @csrf).',
          'الساعة 4: نظام توريث القوالب (@extends, @section, @yield) والمكونات (Blade Components).',
        ],
        oneHourPracticeGoal: 'بناء موقع مصغر لعرض مقالات بـ 3 صفحات تعتمد على Layout رئيسي موحد ومتحكم منظم.',
        links: [
          LessonLink(
            title: 'Laravel Controllers & Blade Engine',
            url: 'https://laravel.com/docs/controllers',
            sourceName: 'Laravel Docs',
            type: 'doc',
          ),
        ],
      ),
      CurriculumDay(
        dayNumber: 14,
        phaseId: 3,
        phaseTitle: 'المرحلة 3: إطار العمل Laravel وبناء REST APIs',
        phaseBadge: 'إتقان لارفيل والـ APIs (28 يوم)',
        title: 'تهجير الجداول (Migrations) ومحرك النماذج Eloquent ORM',
        description: 'إدارة مخطط قاعدة البيانات عبر الكود (Migrations) والتعامل مع النماذج Models والعمليات السحرية.',
        fourHourStudyGoals: [
          'الساعة 1: مفهوم Migrations: إنشاء الجداول، تعديلها، وأوامر artisan migrate, rollback, fresh.',
          'الساعة 2: إنشاء النماذج Models ومفهوم Eloquent ORM (Active Record Pattern).',
          'الساعة 3: الحقول المحمية (\$fillable, \$guarded) والتعامل الآمن مع Mass Assignment.',
          'الساعة 4: استعلامات Eloquent المتقدمة (where, orderBy, limit, paginate, firstOrFail).',
        ],
        oneHourPracticeGoal: 'إنشاء جدول منتجات Products عبر Migration وإنشاء Model وإضافة وتعديل منتجات عبر كود لارفيل.',
        links: [
          LessonLink(
            title: 'Laravel Migrations & Eloquent ORM',
            url: 'https://laravel.com/docs/eloquent',
            sourceName: 'Laravel Docs',
            type: 'doc',
          ),
        ],
      ),
      CurriculumDay(
        dayNumber: 15,
        phaseId: 3,
        phaseTitle: 'المرحلة 3: إطار العمل Laravel وبناء REST APIs',
        phaseBadge: 'إتقان لارفيل والـ APIs (28 يوم)',
        title: 'علاقات قواعد البيانات في Eloquent (Relationships)',
        description: 'بناء وإدارة العلاقات (One to One, One to Many, Many to Many) وحل مشكلة N+1 المشهورة.',
        fourHourStudyGoals: [
          'الساعة 1: علاقة واحد لواحد One to One (hasOne, belongsTo).',
          'الساعة 2: علاقة واحد لمتعدد One to Many (hasMany, belongsTo) كالقسم والمنتجات.',
          'الساعة 3: علاقة متعدد لمتعدد Many to Many والجداول الوسيطة (belongsToMany, Pivot tables).',
          'الساعة 4: تسريع الاستعلامات وتجنب بطء السيرفر: Eager Loading (with()) مقابل Lazy Loading.',
        ],
        oneHourPracticeGoal: 'بناء علاقة بين User و Post و Comment مع استرجاع المستخدم وجميع منشوراته بتعليقاتها في استعلام واحد محسن.',
        links: [
          LessonLink(
            title: 'شرح علاقات لارفيل كاملة - وائل أبو حمزة',
            url: 'https://www.youtube.com/results?search_query=laravel+relationships+wael+abo+hamza',
            sourceName: 'YouTube Tutorials',
          ),
        ],
      ),
      CurriculumDay(
        dayNumber: 16,
        phaseId: 3,
        phaseTitle: 'المرحلة 3: إطار العمل Laravel وبناء REST APIs',
        phaseBadge: 'إتقان لارفيل والـ APIs (28 يوم)',
        title: 'بناء أول RESTful API وتحويل البيانات عبر API Resources',
        description: 'فهم معايير الـ REST API، حالات الـ HTTP Status Codes، وإرجاع استجابات JSON منظمة.',
        fourHourStudyGoals: [
          'الساعة 1: ما هو REST API وما الفرق بينه وبين الويب التقليدي؟ مفهوم Endpoints وطرق HTTP (GET, POST, PUT, DELETE).',
          'الساعة 2: معاني رموز الحالات (200 OK, 201 Created, 400 Bad Request, 401 Unauthorized, 404 Not Found, 500).',
          'الساعة 3: إنشاء API Resource و Resource Collection لتنسيق بيانات الـ JSON وحجب الحقول الحساسة.',
          'الساعة 4: كتابة Response موحد ومرتب يحتوي على: success, message, data, status.',
        ],
        oneHourPracticeGoal: 'بناء Resource Controller كامل لـ Products API واختبار استعراض المنتجات وجلب منتج مفرد بالـ ID عبر Postman.',
        links: [
          LessonLink(
            title: 'بناء API في لارفيل - كورس احترافي',
            url: 'https://www.youtube.com/results?search_query=laravel+api+resource+arabic',
            sourceName: 'YouTube Tutorials',
          ),
          LessonLink(
            title: 'Laravel Eloquent: API Resources',
            url: 'https://laravel.com/docs/eloquent-resources',
            sourceName: 'Official Docs',
            type: 'doc',
          ),
        ],
      ),
      CurriculumDay(
        dayNumber: 17,
        phaseId: 3,
        phaseTitle: 'المرحلة 3: إطار العمل Laravel وبناء REST APIs',
        phaseBadge: 'إتقان لارفيل والـ APIs (28 يوم)',
        title: 'التحقق من البيانات (Form Requests & Validation)',
        description: 'حماية الـ API من البيانات الخاطئة عبر طبقة Form Requests القوية ورسائل الأخطاء المخصصة.',
        fourHourStudyGoals: [
          'الساعة 1: قواعد التحقق في لارفيل: required, email, unique, min, max, image, mimes.',
          'الساعة 2: إنشاء Form Request مخصص: php artisan make:request StoreProductRequest.',
          'الساعة 3: تخصيص دالة authorize() ورسائل الخطأ العربية (Custom Messages).',
          'الساعة 4: التعامل مع أخطاء التحقق في الـ API وإرجاع Status 422 Unprocessable Entity مع مصفوفة أخطاء واضحة.',
        ],
        oneHourPracticeGoal: 'بناء عملية إضافة وتعديل منتج في الـ API مع التحقق الصارم من الاسم، السعر، الصورة، والقسم وإرجاع ردود واضحة للموبايل.',
        links: [
          LessonLink(
            title: 'Laravel Validation In Depth',
            url: 'https://laravel.com/docs/validation',
            sourceName: 'Laravel Docs',
            type: 'doc',
          ),
        ],
      ),
      CurriculumDay(
        dayNumber: 18,
        phaseId: 3,
        phaseTitle: 'المرحلة 3: إطار العمل Laravel وبناء REST APIs',
        phaseBadge: 'إتقان لارفيل والـ APIs (28 يوم)',
        title: 'نظام المصادقة وحماية الـ APIs باستخدام Laravel Sanctum',
        description: 'بناء نظام تسجيل، تسجيل دخول، وخروج آمن يعتمد على الـ Bearer Tokens لتطبيقات الموبايل.',
        fourHourStudyGoals: [
          'الساعة 1: كيف تعمل المصادقة بدون جلسات (Stateless Token Authentication) في تطبيقات الموبايل.',
          'الساعة 2: تثبيت وضبط حزمة Laravel Sanctum وإعداد الـ HasApiTokens Trait في نموذج User.',
          'الساعة 3: بناء Register & Login Endpoints وتشفير كلمات المرور عبر Hash::make وإصدار التوكن createToken.',
          'الساعة 4: بناء Logout وحذف التوكنات، وحماية المسارات باستخدام Middleware auth:sanctum.',
        ],
        oneHourPracticeGoal: 'اختبار دورة المصادقة كاملة على Postman: تسجيل مستخدم جديد، الحصول على Token، استخدام الـ Token للوصول لبيانات الملف الشخصي، ثم تسجيل الخروج.',
        links: [
          LessonLink(
            title: 'Laravel Sanctum API Authentication Guide',
            url: 'https://laravel.com/docs/sanctum',
            sourceName: 'Laravel Docs',
            type: 'doc',
          ),
          LessonLink(
            title: 'شرح Laravel Sanctum بالفيديو للموبايل',
            url: 'https://www.youtube.com/results?search_query=laravel+sanctum+api+auth+arabic',
            sourceName: 'YouTube Tutorials',
          ),
        ],
      ),

      // ==========================================
      // PHASE 4: Dart Language Mastery
      // ==========================================
      CurriculumDay(
        dayNumber: 19,
        phaseId: 4,
        phaseTitle: 'المرحلة 4: لغة Dart والبرمجة الشيئية لتطبيقات الموبايل',
        phaseBadge: 'إتقان Dart (14 يوم)',
        title: 'أساسيات لغة Dart ونظام الأمان الصارم (Null Safety)',
        description: 'تعلم لغة دارت المستخدمة في فلاتر، الأنواع، المتغيرات، وفهم نظام الحماية من قيم Null.',
        fourHourStudyGoals: [
          'الساعة 1: مقدمة Dart، تشغيل الأكواد على DartPad، وأنواع المتغيرات الصريحة (int, double, String, bool).',
          'الساعة 2: الكلمات المفتاحية var, dynamic, final, const والفروق الدقيقة في الذاكرة.',
          'الساعة 3: مفهوم Null Safety الأهم في Dart: الفرق بين String و String?، وعلامات ?, !, ??, ?..',
          'الساعة 4: القوائم والمجموعات والخرائط: List<T>, Set<T>, Map<K,V> ودوال التصفية والتحويل map, where.',
        ],
        oneHourPracticeGoal: 'حل 5 تمارين متنوعة على DartPad تغطي فحص الـ Null، وتصفية قائمة مستخدمين واستخراج أسمائهم بحروف كبيرة.',
        links: [
          LessonLink(
            title: 'دورة لغة Dart كاملة - ثروت سامي',
            url: 'https://www.youtube.com/playlist?list=PL93xoG4309c3h1i2B_iWc4vQcM2_lK6Yk',
            sourceName: 'Tharwat Samy',
          ),
          LessonLink(
            title: 'DartPad Online Code Editor',
            url: 'https://dartpad.dev/',
            sourceName: 'Dart Online IDE',
            type: 'exercise',
          ),
        ],
      ),
      CurriculumDay(
        dayNumber: 20,
        phaseId: 4,
        phaseTitle: 'المرحلة 4: لغة Dart والبرمجة الشيئية لتطبيقات الموبايل',
        phaseBadge: 'إتقان Dart (14 يوم)',
        title: 'البرمجة كائنية التوجه OOP المتقدمة في Dart',
        description: 'الفئات المتقدمة، المنشئات المسماة (Named Constructors)، والوراثة والـ Mixins.',
        fourHourStudyGoals: [
          'الساعة 1: تعريف الـ Classes ومحددات الوصول الخاصة (_) في Dart، ودوال Getters & Setters المختصرة.',
          'الساعة 2: أنواع الـ Constructors في Dart: Generative, Named, Factory, Const Constructors.',
          'الساعة 3: الوراثة والواجهات الضمنية (Implicit Interfaces) واستخدام implements و extends.',
          'الساعة 4: مفهوم الـ Mixins بالكلمة المفتاحية with، والـ Extension Methods لإضافة وظائف للفئات الجاهزة.',
        ],
        oneHourPracticeGoal: 'بناء فئة Model كاملة لـ UserModel مع Named Constructor (fromJson) وميثود toJson لتحويل البيانات.',
        links: [
          LessonLink(
            title: 'Dart OOP & Factory Constructors - ثروت سامي',
            url: 'https://www.youtube.com/playlist?list=PL93xoG4309c3h1i2B_iWc4vQcM2_lK6Yk',
            sourceName: 'Tharwat Samy',
          ),
        ],
      ),
      CurriculumDay(
        dayNumber: 21,
        phaseId: 4,
        phaseTitle: 'المرحلة 4: لغة Dart والبرمجة الشيئية لتطبيقات الموبايل',
        phaseBadge: 'إتقان Dart (14 يوم)',
        title: 'البرمجة غير المتزامنة (Asynchronous Dart)',
        description: 'فهم الـ Event Loop، واستخدام Future، async / await، والتدفقات المستمرة Streams.',
        fourHourStudyGoals: [
          'الساعة 1: ما هو الـ Single-Threaded Event Loop وكيف تنفذ Dart العمليات الطويلة بدون تجميد التطبيق.',
          'الساعة 2: كائنات Future وحالاتها (Uncompleted, Completed with data, Completed with error).',
          'الساعة 3: كتابة الأكواد غير المتزامنة بأسلوب نظيف عبر async و await وإدارة الأخطاء بـ try-catch.',
          'الساعة 4: مقدمة عن Streams والتعامل مع تدفق البيانات المستمر (StreamController, listen, yield).',
        ],
        oneHourPracticeGoal: 'محاكاة عملية طلب بيانات طقس عبر دالة غير متزامنة تأخذ ثانيتين وترجع نتيجة مع معالجة احتمالية حدوث خطأ.',
        links: [
          LessonLink(
            title: 'Dart Asynchronous Programming Guide',
            url: 'https://dart.dev/codelabs/async-await',
            sourceName: 'Dart Official Docs',
            type: 'doc',
          ),
        ],
      ),

      // ==========================================
      // PHASE 5: Flutter Framework & State Management
      // ==========================================
      CurriculumDay(
        dayNumber: 22,
        phaseId: 5,
        phaseTitle: 'المرحلة 5: إطار عمل Flutter وتطوير التطبيقات',
        phaseBadge: 'احتراف فلاتر (30 يوم)',
        title: 'شجرة الودجتس (Widget Tree) وتصميم الشاشات',
        description: 'فهم فلسفة "Everything is a Widget"، الفرق بين Stateless و Stateful، وتصميم شاشات متجاوبة.',
        fourHourStudyGoals: [
          'الساعة 1: كيف ترسم فلاتر البيكسلات (Engine, Skia/Impeller, Framework)، ودورة حياة الودجت.',
          'الساعة 2: الودجتس البنائية الأساسية: Scaffold, AppBar, Container, SizedBox, Padding.',
          'الساعة 3: ترتيب العناصر وإدارة المساحات: Row, Column, Stack, Expanded, Flexible, SingleChildScrollView.',
          'الساعة 4: التعامل مع القوائم الكبيرة والشبكات بكفاءة عالية: ListView.builder و GridView.builder.',
        ],
        oneHourPracticeGoal: 'تصميم واجهة متجر نظيفة تحتوي على شريط علوي، قائمة أصناف أفقية، وشبكة منتجات عمودية.',
        links: [
          LessonLink(
            title: 'دورة Flutter كاملة من الصفر - ثروت سامي',
            url: 'https://www.youtube.com/playlist?list=PL93xoG4309c1K_o8Yw_C0Xk8t3K7pP1_e',
            sourceName: 'Tharwat Samy',
          ),
          LessonLink(
            title: 'Flutter Widget of the Week',
            url: 'https://www.youtube.com/playlist?list=PLjxrf2q8roU23XGwz3Km7sQZFTdB996iG',
            sourceName: 'Flutter Official',
          ),
        ],
      ),
      CurriculumDay(
        dayNumber: 23,
        phaseId: 5,
        phaseTitle: 'المرحلة 5: إطار عمل Flutter وتطوير التطبيقات',
        phaseBadge: 'احتراف فلاتر (30 يوم)',
        title: 'المدخلات والنماذج والتصميم الاحترافي Material 3',
        description: 'التعامل مع حقول الإدخال TextField، التحقق من النماذج Form، والسمات والألوان المتقدمة.',
        fourHourStudyGoals: [
          'الساعة 1: حقول النصوص TextField و TextFormField، والتحكم بالقيم عبر TextEditingController.',
          'الساعة 2: التحقق من صحة المدخلات عبر Form و GlobalKey<FormState> والـ validator.',
          'الساعة 3: تطبيق فلسفة Material 3 Design، تخصيص الألوان والسمات (ThemeData, ColorScheme).',
          'الساعة 4: الأزرار بأنواعها (ElevatedButton, OutlinedButton, TextButton, FloatingActionButton) وحالات التحميل.',
        ],
        oneHourPracticeGoal: 'بناء شاشة تسجيل دخول كاملة متجاوبة مع حقول إيميل وكلمة سر، إظهار/إخفاء الباسورد، وأزرار أنيقة.',
        links: [
          LessonLink(
            title: 'Flutter Forms & Validation Guide',
            url: 'https://docs.flutter.dev/cookbook/forms/validation',
            sourceName: 'Flutter Docs',
            type: 'doc',
          ),
        ],
      ),
      CurriculumDay(
        dayNumber: 24,
        phaseId: 5,
        phaseTitle: 'المرحلة 5: إطار عمل Flutter وتطوير التطبيقات',
        phaseBadge: 'احتراف فلاتر (30 يوم)',
        title: 'إدارة الحالة المتقدمة بسوق العمل: Cubit & Bloc',
        description: 'تعلم معيار سوق العمل لإدارة الحالة في فلاتر لفصل واجهة المستخدم كلياً عن منطق التطبيق.',
        fourHourStudyGoals: [
          'الساعة 1: ما هي إدارة الحالة (State Management) ولماذا لا تكفي setState في التطبيقات الكبيرة؟',
          'الساعة 2: تثبيت حزمة flutter_bloc وفهم فلسفة الـ Cubit وحالاته (Initial, Loading, Success, Failure).',
          'الساعة 3: استخدام BlocProvider لتوفير الـ Cubit واستخدام BlocBuilder لإعادة بناء الواجهة بحسب الحالة.',
          'الساعة 4: استخدام BlocListener لتنفيذ الأحداث الأحادية مثل إظهار SnackBar أو الانتقال لشاشة أخرى.',
        ],
        oneHourPracticeGoal: 'تحويل تطبيق Todo أو سلة مشتريات ليعمل بالكامل عبر Cubit و BlocBuilder مع فصل كامل للمنطق.',
        links: [
          LessonLink(
            title: 'شرح Bloc & Cubit باحتراف - ثروت سامي',
            url: 'https://www.youtube.com/results?search_query=flutter+cubit+tharwat+samy',
            sourceName: 'Tharwat Samy',
          ),
          LessonLink(
            title: 'Bloc Library Official Documentation',
            url: 'https://bloclibrary.dev/',
            sourceName: 'Official Docs',
            type: 'doc',
          ),
        ],
      ),
      CurriculumDay(
        dayNumber: 25,
        phaseId: 5,
        phaseTitle: 'المرحلة 5: إطار عمل Flutter وتطوير التطبيقات',
        phaseBadge: 'احتراف فلاتر (30 يوم)',
        title: 'التعامل مع الـ APIs والشبكات عبر حزمة Dio',
        description: 'إرسال طلبات HTTP احترافية، معالجة استجابات JSON، استخدام Interceptors، وإدارة الأخطاء.',
        fourHourStudyGoals: [
          'الساعة 1: لماذا نفضل حزمة Dio على مكتبة http العادية (Interceptors, CancelToken, Global Configs).',
          'الساعة 2: إعداد كلاس ApiService موحد وتحديد BaseOptions (BaseUrl, Timeouts, Headers).',
          'الساعة 3: إرسال طلبات GET, POST, PUT, DELETE وتحويل الـ JSON تلقائياً لنماذج Dart Models.',
          'الساعة 4: استخدام Interceptors لتمرير الـ Bearer Token تلقائياً في كل طلب وطباعة الـ Logs عبر PrettyDioLogger.',
        ],
        oneHourPracticeGoal: 'إنشاء كلاس DioHelper واستدعاء API خارجي حقيقي وجلب قائمة عناصر وعرضها في شاشة ListView أنيقة.',
        links: [
          LessonLink(
            title: 'Dio Package Documentation & Tutorial',
            url: 'https://pub.dev/packages/dio',
            sourceName: 'Pub.dev',
            type: 'doc',
          ),
        ],
      ),

      // ==========================================
      // PHASE 6: Full-Stack Integration (Flutter + Laravel)
      // ==========================================
      CurriculumDay(
        dayNumber: 26,
        phaseId: 6,
        phaseTitle: 'المرحلة 6: التكامل الشامل Full-Stack ومشاريع الـ Mid-Level',
        phaseBadge: 'الاحتراف الشامل (21 يوم)',
        title: 'الربط المباشر: ربط مصادقة Flutter مع Laravel Sanctum',
        description: 'تطبيق عملي حقيقي: ربط شاشة تسجيل الدخول في فلاتر بـ API لارفيل وحفظ التوكن في التخزين الآمن.',
        fourHourStudyGoals: [
          'الساعة 1: تجهيز سيرفر لارفيل المحلي ومراعاة إعدادات الـ CORS والـ IP المحلي للاتصال من المحاكي.',
          'الساعة 2: بناء AuthCubit في فلاتر لإدارة عمليات (Login, Register, Logout).',
          'الساعة 3: حفظ الـ Token بأمان باستخدام flutter_secure_storage أو SharedPreferences.',
          'الساعة 4: فحص وجود التوكن عند فتح التطبيق (Auto-Login Splash Screen) والتوجيه للشاشة الرئيسية مباشرة.',
        ],
        oneHourPracticeGoal: 'بناء نظام تسجيل دخول كامل يرسل الإيميل والباسورد لـ Laravel API، ويخزن التوكن ويفتح شاشة الـ Dashboard.',
        links: [
          LessonLink(
            title: 'ربط فلاتر مع لارفيل API - مشروع متكامل',
            url: 'https://www.youtube.com/results?search_query=flutter+laravel+sanctum+integration+arabic',
            sourceName: 'YouTube Tutorials',
          ),
        ],
      ),
      CurriculumDay(
        dayNumber: 27,
        phaseId: 6,
        phaseTitle: 'المرحلة 6: التكامل الشامل Full-Stack ومشاريع الـ Mid-Level',
        phaseBadge: 'الاحتراف الشامل (21 يوم)',
        title: 'المعمارية النظيفة (Clean Architecture) وتنظيم الكود',
        description: 'تطبيق معمارية المطورين المحترفين: فصل طبقة البيانات (Data)، النطاق (Domain)، والعرض (Presentation).',
        fourHourStudyGoals: [
          'الساعة 1: ما هي Clean Architecture ولماذا تشترطها الشركات للمطور Mid-Level؟',
          'الساعة 2: طبقة الـ Data: (Models, Data Sources, Repositories Implementation).',
          'الساعة 3: طبقة الـ Domain: (Entities, Use Cases, Repositories Interfaces) وقاعدة عدم الاعتمادية.',
          'الساعة 4: طبقة الـ Presentation: (UI Views, Cubits/Blocs) وحقن التبعيات عبر get_it.',
        ],
        oneHourPracticeGoal: 'إعادة هيكلة ميزة واحدة (Feature: Products) بالكامل وفق أسلوب Clean Architecture مع UseCase و Repository.',
        links: [
          LessonLink(
            title: 'شرح Clean Architecture في فلاتر - ثروت سامي',
            url: 'https://www.youtube.com/results?search_query=clean+architecture+flutter+tharwat+samy',
            sourceName: 'Tharwat Samy',
          ),
        ],
      ),
      CurriculumDay(
        dayNumber: 28,
        phaseId: 6,
        phaseTitle: 'المرحلة 6: التكامل الشامل Full-Stack ومشاريع الـ Mid-Level',
        phaseBadge: 'الاحتراف الشامل (21 يوم)',
        title: 'الإشعارات الحية وتتبع الطلبات المباشر (FCM & Realtime)',
        description: 'إرسال الإشعارات من خادم لارفيل إلى تطبيق الموبايل، ومقدمة الـ WebSockets لتحديث البيانات اللحظي.',
        fourHourStudyGoals: [
          'الساعة 1: ضبط مشروع Firebase وتفعيل خدمة الإشعارات Firebase Cloud Messaging (FCM).',
          'الساعة 2: استقبال الإشعارات في فلاتر في الحالات الثلاث: Foreground, Background, Terminated.',
          'الساعة 3: إرسال الإشعارات من الباك إند بلارفيل عند حدوث حدث (تغيير حالة طلب، إرسال رسالة).',
          'الساعة 4: مفهوم الـ WebSockets واستخدام Pusher / Soketi لتحديث الواجهة لحظياً بدون إعادة تحميل.',
        ],
        oneHourPracticeGoal: 'بناء تجربة إشعار حية حيث يرسل لارفيل إشعاراً عند إضافة طلب، ويظهر تنبيه فوري في فلاتر.',
        links: [
          LessonLink(
            title: 'Firebase Push Notifications in Flutter',
            url: 'https://firebase.google.com/docs/cloud-messaging/flutter/client',
            sourceName: 'Firebase Docs',
            type: 'doc',
          ),
        ],
      ),
      CurriculumDay(
        dayNumber: 29,
        phaseId: 6,
        phaseTitle: 'المرحلة 6: التكامل الشامل Full-Stack ومشاريع الـ Mid-Level',
        phaseBadge: 'الاحتراف الشامل (21 يوم)',
        title: 'مشروع التخرج المتكامل: تطبيق تجارة أو توصيل مع لوحة تحكم',
        description: 'تجميع كل المهارات في مشروع متكامل يرفعك لدرجة Mid-Level لتقديمه للشركات.',
        fourHourStudyGoals: [
          'الساعة 1: تصميم قاعدة بيانات وواجهات API متكاملة بلارفيل (Auth, Categories, Products, Cart, Orders, Reviews).',
          'الساعة 2: بناء تطبيق الموبايل بفلاتر: التنقل بالـ GoRouter أو AutoRoute، إدارة الحالة بالـ Cubit.',
          'الساعة 3: ميزات متقدمة: البحث اللحظي، الفلترة بالسعر، الكاش المحلي عند انقطاع الإنترنت (Offline First).',
          'الساعة 4: تحسين الأداء وحجم التطبيق، وحل مشاكل تسريب الذاكرة (Memory Leaks).',
        ],
        oneHourPracticeGoal: 'إنهاء ميزة سلة المشتريات وإتمام الطلب وحفظه في داتابيز لارفيل وعرض رسالة نجاح متحركة.',
        links: [
          LessonLink(
            title: 'Full Stack Flutter & Laravel Multi-vendor App',
            url: 'https://www.youtube.com/results?search_query=flutter+laravel+fullstack+app',
            sourceName: 'YouTube Tutorials',
          ),
        ],
      ),
      CurriculumDay(
        dayNumber: 30,
        phaseId: 6,
        phaseTitle: 'المرحلة 6: التكامل الشامل Full-Stack ومشاريع الـ Mid-Level',
        phaseBadge: 'الاحتراف الشامل (21 يوم)',
        title: 'تجهيز السيرة الذاتية والبورتفوليو وأسئلة المقابلات التقنية',
        description: 'كيف تسوق لنفسك، إبراز المشاريع على GitHub، وأشهر أسئلة المقابلات الفنية للوصول لرتبة Mid-Level.',
        fourHourStudyGoals: [
          'الساعة 1: كتابة سيرة ذاتية متوافقة مع أنظمة ATS للمطورين تركز على المهارات العملية والمشاريع المنجزة.',
          'الساعة 2: تجهيز الـ GitHub Profile وعمل README احترافي لكل مشروع يحتوي على صور وفيديو توضيحي و Architecture Diagram.',
          'الساعة 3: أشهر 30 سؤال تقني في Flutter (Widget lifecycle, Keys, BuildContext, InheritedWidget, Streams, Isolates).',
          'الساعة 4: أشهر 30 سؤال تقني في Laravel (Service Providers, Dependency Injection, Queues, Eloquent Performance, SOLID Principles).',
        ],
        oneHourPracticeGoal: 'تسجيل فيديو شاشة مدته 3 دقائق يشرح كود تطبيقك وهندسته المعمارية ورفعه على LinkedIn.',
        links: [
          LessonLink(
            title: 'Flutter Interview Questions Repository',
            url: 'https://github.com/topics/flutter-interview-questions',
            sourceName: 'GitHub Community',
            type: 'doc',
          ),
          LessonLink(
            title: 'Laravel Interview Questions Guide',
            url: 'https://github.com/topics/laravel-interview-questions',
            sourceName: 'GitHub Community',
            type: 'doc',
          ),
        ],
      ),
    ];
  }
}
