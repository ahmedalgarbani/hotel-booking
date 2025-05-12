INSERT INTO ChartOfAccounts (account_number, account_name, account_type, account_balance, account_description, account_status, account_amount) VALUES
('1000', 'الأصول', 'Assets', 0.00, 'جميع الأصول التي تملكها الشركة', TRUE, NULL),
('1100', 'الأصول المتداولة', 'Assets', 0.00, 'الأصول التي يتم تحويلها إلى نقد خلال عام', TRUE, NULL),
('1200', 'الأصول الثابتة', 'Assets', 0.00, 'الأصول التي تملكها الشركة على المدى الطويل', TRUE, NULL),
('2000', 'الخصوم', 'Liabilities', 0.00, 'الالتزامات المالية على الشركة', TRUE, NULL),
('2100', 'الخصوم المتداولة', 'Liabilities', 0.00, 'الالتزامات قصيرة الأجل', TRUE, NULL),
('2200', 'الخصوم طويلة الأجل', 'Liabilities', 0.00, 'الالتزامات المالية المستحقة بعد أكثر من عام', TRUE, NULL),
('3000', 'حقوق الملكية', 'Equity', 0.00, 'القيمة الصافية للشركة', TRUE, NULL),
('3100', 'رأس المال', 'Equity', 0.00, 'المبلغ الذي يساهم به الملاك في الشركة', TRUE, NULL),
('3200', 'الأرباح المحتجزة', 'Equity', 0.00, 'الأرباح التي لم يتم توزيعها على المساهمين', TRUE, NULL),
('4000', 'الإيرادات', 'Revenue', 0.00, 'الإيرادات المكتسبة من الأنشطة التجارية', TRUE, NULL),
('4100', 'المبيعات', 'Revenue', 0.00, 'إجمالي المبيعات التي تحققها الشركة', TRUE, NULL),
('4200', 'الإيرادات الأخرى', 'Revenue', 0.00, 'إيرادات غير تشغيلية', TRUE, NULL),
('5000', 'المصروفات', 'Expenses', 0.00, 'التكاليف التشغيلية للشركة', TRUE, NULL),
('5100', 'الرواتب والأجور', 'Expenses', 0.00, 'تكاليف الموظفين', TRUE, NULL),
('5200', 'مصروف الإيجار', 'Expenses', 0.00, 'تكلفة استئجار المكاتب والمرافق', TRUE, NULL),
('5300', 'المصروفات التسويقية', 'Expenses', 0.00, 'نفقات الترويج والتسويق', TRUE, NULL);


-- Insert main account categories
INSERT INTO accounts_chartofaccounts (account_number, account_name, account_type, account_parent, account_description)
VALUES 
('1100', 'الأصول الثابتة', 'Assets', NULL, 'الأصول الثابتة للشركة'),
('1200', 'أصول أخرى', 'Assets', NULL, 'الأصول غير المصنفة');

-- Current Assets (1000 series) - Parent: '1100' (Fixed Assets)
INSERT INTO accounts_chartofaccounts (account_number, account_name, account_type, account_parent, account_description)
SELECT '1101', 'النقد وما يعادله', 'Assets', id, 'النقدية وما يعادلها من أصول سائلة'
FROM accounts_chartofaccounts WHERE account_number = '1100';

INSERT INTO accounts_chartofaccounts (account_number, account_name, account_type, account_parent, account_description)
SELECT '1102', 'النقدية في الصندوق', 'Assets', id, 'النقدية المتوفرة في صندوق الشركة'
FROM accounts_chartofaccounts WHERE account_number = '1010';

INSERT INTO accounts_chartofaccounts (account_number, account_name, account_type, account_parent, account_description)
SELECT '1103', 'البنك الأهلي - الحساب الجاري', 'Assets', id, 'الحساب الجاري في البنك الأهلي'
FROM accounts_chartofaccounts WHERE account_number = '1010';

-- Parent: '1100' (Fixed Assets)
INSERT INTO accounts_chartofaccounts (account_number, account_name, account_type, account_parent, account_description)
SELECT '1104', 'المدينون والعملاء', 'Assets', id, 'ذمم العملاء والمدينون'
FROM accounts_chartofaccounts WHERE account_number = '1100';

INSERT INTO accounts_chartofaccounts (account_number, account_name, account_type, account_parent, account_description)
SELECT '1105', 'عملاء محليون', 'Assets', id, 'ذمم العملاء المحليين'
FROM accounts_chartofaccounts WHERE account_number = '1020';

INSERT INTO accounts_chartofaccounts (account_number, account_name, account_type, account_parent, account_description)
SELECT '1106', 'عملاء دوليون', 'Assets', id, 'ذمم العملاء الدوليين'
FROM accounts_chartofaccounts WHERE account_number = '1020';

-- Inventory (1030 series) - Parent: '1100' (Fixed Assets)
INSERT INTO accounts_chartofaccounts (account_number, account_name, account_type, account_parent, account_description)
SELECT '1107', 'المخزون', 'Assets', id, 'مخزون المواد والبضائع'
FROM accounts_chartofaccounts WHERE account_number = '1100';

INSERT INTO accounts_chartofaccounts (account_number, account_name, account_type, account_parent, account_description)
SELECT '1108', 'مخزون المواد الخام', 'Assets', id, 'مواد خام غير مصنعة'
FROM accounts_chartofaccounts WHERE account_number = '1030';

INSERT INTO accounts_chartofaccounts (account_number, account_name, account_type, account_parent, account_description)
SELECT '1032', 'مخزون البضاعة التامة', 'Assets', id, 'بضاعة جاهزة للبيع'
FROM accounts_chartofaccounts WHERE account_number = '1030';

-- Fixed Assets (1100 series) - Parent: '1100' (Fixed Assets)
INSERT INTO accounts_chartofaccounts (account_number, account_name, account_type, account_parent, account_description)
SELECT '1110', 'المباني والآلات', 'Assets', id, 'المباني والآلات والمعدات'
FROM accounts_chartofaccounts WHERE account_number = '1100';

INSERT INTO accounts_chartofaccounts (account_number, account_name, account_type, account_parent, account_description)
SELECT '1111', 'الأراضي', 'Assets', id, 'أراضي مملوكة للشركة'
FROM accounts_chartofaccounts WHERE account_number = '1110';

INSERT INTO accounts_chartofaccounts (account_number, account_name, account_type, account_parent, account_description)
SELECT '1112', 'المباني', 'Assets', id, 'مباني مملوكة للشركة'
FROM accounts_chartofaccounts WHERE account_number = '1110';

-- Vehicles (1120 series) - Parent: '1100' (Fixed Assets)
INSERT INTO accounts_chartofaccounts (account_number, account_name, account_type, account_parent, account_description)
SELECT '1120', 'المركبات', 'Assets', id, 'مركبات الشركة'
FROM accounts_chartofaccounts WHERE account_number = '1100';

-- Depreciation (1130 series) - Parent: '1100' (Fixed Assets)
INSERT INTO accounts_chartofaccounts (account_number, account_name, account_type, account_parent, account_description)
SELECT '1130', 'مجمع الإهلاك', 'Assets', id, 'مجمع إهلاك الأصول الثابتة'
FROM accounts_chartofaccounts WHERE account_number = '1100';

-- Other Assets (1200 series) - Parent: '1200' (Other Assets)
INSERT INTO accounts_chartofaccounts (account_number, account_name, account_type, account_parent, account_description)
SELECT '1210', 'الأصول غير الملموسة', 'Assets', id, 'براءات الاختراع والعلامات التجارية'
FROM accounts_chartofaccounts WHERE account_number = '1200';

INSERT INTO accounts_chartofaccounts (account_number, account_name, account_type, account_parent, account_description)
SELECT '120', 'استثمارات طويلة الأجل', 'Assets', id, 'استثمارات لأكثر من سنة'
FROM accounts_chartofaccounts WHERE account_number = '1200';



-- Inserting main liabilities categories (الخصوم)
INSERT INTO accounts_chartofaccounts (account_number, account_name, account_type, account_parent, account_description)
VALUES 
('2000', 'الخصوم المتداولة', 'الخصوم', NULL, 'الخصوم المتداولة قصيرة الأجل'),
('2100', 'الخصوم غير المتداولة', 'الخصوم', NULL, 'الخصوم طويلة الأجل');

-- Current Liabilities (2000 series)
-- Parent: '2000' (الخصوم المتداولة)
INSERT INTO accounts_chartofaccounts (account_number, account_name, account_type, account_parent_id, account_description)
SELECT '2101', 'الحسابات الدائنة', 'الخصوم', 25, 'المبالغ المستحقة على الشركة للموردين'

INSERT INTO accounts_chartofaccounts (account_number, account_name, account_type, account_parent_id, account_description)
SELECT '2102', 'القروض قصيرة الأجل', 'الخصوم', 25, 'القروض التي يجب سدادها خلال عام'

INSERT INTO accounts_chartofaccounts (account_number, account_name, account_type, account_parent_id, account_description)
SELECT '2103', 'المصروفات المستحقة', 'الخصوم', 25, 'المصروفات التي تم تكبدها ولم تسدد بعد'

-- Non-Current Liabilities (2100 series)
-- Parent: '2100' (الخصوم غير المتداولة)
INSERT INTO accounts_chartofaccounts (account_number, account_name, account_type, account_parent_id, account_description)
SELECT '2201', 'القروض طويلة الأجل', 'الخصوم', 26, 'القروض التي يجب سدادها بعد أكثر من عام'

INSERT INTO accounts_chartofaccounts (account_number, account_name, account_type, account_parent_id, account_description)
SELECT '2202', 'الذمم المدينة طويلة الأجل', 'الخصوم', 26, 'المبالغ المستحقة على الشركة التي سيتم تسديدها بعد أكثر من عام'

INSERT INTO accounts_chartofaccounts (account_number, account_name, account_type, account_parent_id, account_description)
SELECT '2203', 'الالتزامات الضريبية طويلة الأجل', 'الخصوم', 26, 'الضرائب المستحقة التي سيتم دفعها بعد أكثر من عام'























-- الأسهم العادية (Common Stock)
INSERT INTO accounts_chartofaccounts (account_number, account_name, account_type, account_parent_id, account_description)
values '3100', 'الأسهم العادية', 'حقوق الملكية', 3, 'رأس المال الذي استثمره الملاك أو المساهمون'

-- الأرباح المحتجزة (Retained Earnings)
INSERT INTO accounts_chartofaccounts (account_number, account_name, account_type, account_parent_id, account_description)
values '3200', 'الأرباح المحتجزة', 'حقوق الملكية', 3, 'الأرباح أو الخسائر المتراكمة التي لم يتم توزيعها'

-- رأس المال المدفوع الإضافي (Additional Paid-In Capital)
INSERT INTO accounts_chartofaccounts (account_number, account_name, account_type, account_parent_id, account_description)
values '3300', 'رأس المال المدفوع الإضافي', 'حقوق الملكية', 3, 'المبالغ المدفوعة من المساهمين بما يتجاوز القيمة الاسمية للأسهم'

-- الأسهم المستعادة (Treasury Stock)
INSERT INTO accounts_chartofaccounts (account_number, account_name, account_type, account_parent_id, account_description)
values '3400', 'الأسهم المستعادة', 'حقوق الملكية', 3, 'الأسهم التي تم شراؤها مرة أخرى من السوق المفتوحة'












-- 1. إيرادات المبيعات (Sales Revenue)
INSERT INTO accounts_chartofaccounts (account_number, account_name, account_type, account_parent_id, account_description)
SELECT '4100', 'إيرادات المبيعات', 'الإيرادات', 4, 'الإيرادات الناتجة عن مبيعات المنتجات'

-- 2. إيرادات الخدمات (Service Revenue)
INSERT INTO accounts_chartofaccounts (account_number, account_name, account_type, account_parent_id, account_description)
values '4200', 'إيرادات الخدمات', 'الإيرادات', 4, 'الإيرادات الناتجة عن تقديم الخدمات'

-- 3. إيرادات أخرى (Other Revenue)
INSERT INTO accounts_chartofaccounts (account_number, account_name, account_type, account_parent_id, account_description)
values '4300', 'إيرادات أخرى', 'الإيرادات', 4, 'إيرادات غير رئيسية مثل الفوائد أو الإيجارات'

-- 4. إيرادات الاستثمار (Investment Revenue)
INSERT INTO accounts_chartofaccounts (account_number, account_name, account_type, account_parent_id, account_description)
values '4400', 'إيرادات الاستثمار', 'الإيرادات', 4, 'الإيرادات الناتجة عن الاستثمارات والعوائد المالية'

-- 5. إيرادات الخصومات (Discount Revenue)
INSERT INTO accounts_chartofaccounts (account_number, account_name, account_type, account_parent_id, account_description)
values '4500', 'إيرادات الخصومات', 'الإيرادات', 4, 'الإيرادات الناتجة عن الخصومات المقدمة للعملاء'






















-- 1. تكلفة البضائع المباعة (Cost of Goods Sold)
INSERT INTO accounts_chartofaccounts (account_number, account_name, account_type, account_parent_id, account_description)
values '5100', 'تكلفة البضائع المباعة', 'المصاريف', 6, 'التكاليف المباشرة المرتبطة بإنتاج السلع المباعة'

-- 2. المصاريف التشغيلية (Operating Expenses)
INSERT INTO accounts_chartofaccounts (account_number, account_name, account_type, account_parent_id, account_description)
values '5200', 'المصاريف التشغيلية', 'المصاريف', 6, 'النفقات المتعلقة بتشغيل الشركة اليومية'

-- 3. مصاريف الرواتب والأجور (Salaries and Wages Expense)
INSERT INTO accounts_chartofaccounts (account_number, account_name, account_type, account_parent_id, account_description)
values '5300', 'مصاريف الرواتب والأجور', 'المصاريف', 6, 'تكاليف دفع الرواتب والأجور للموظفين'

-- 4. مصاريف الإيجار (Rent Expense)
INSERT INTO accounts_chartofaccounts (account_number, account_name, account_type, account_parent_id, account_description)
values '5400', 'مصاريف الإيجار', 'المصاريف', 6, 'تكاليف استئجار المكاتب أو المنشآت'

-- 5. مصاريف المرافق (Utilities Expense)
INSERT INTO accounts_chartofaccounts (account_number, account_name, account_type, account_parent_id, account_description)
values '5500', 'مصاريف المرافق', 'المصاريف', 6, 'تكاليف فواتير المرافق مثل الكهرباء والمياه والإنترنت'

-- 6. مصاريف التسويق والإعلان (Marketing and Advertising Expense)
INSERT INTO accounts_chartofaccounts (account_number, account_name, account_type, account_parent_id, account_description)
values '5600', 'مصاريف التسويق والإعلان', 'المصاريف', 6, 'تكاليف الحملات التسويقية والإعلانية'

-- 7. مصاريف أخرى (Other Expenses)
INSERT INTO accounts_chartofaccounts (account_number, account_name, account_type, account_parent_id, account_description)
values '5700', 'مصاريف أخرى', 'المصاريف', 6, 'مصاريف أخرى غير مصنفة'
