import 'package:hrms/api/services/department_service.dart';
import 'package:hrms/api/services/employee_type_service.dart';
import 'package:hrms/api/services/qr_code_setting_service.dart';

import 'services/api_service.dart';
import 'services/company_service.dart';
import 'services/employee_service.dart';

class ApiProvider {
  static final ApiProvider _instance = ApiProvider._internal();
  factory ApiProvider() => _instance;

  late ApiService _apiService;

  late CompanyService _companyService;

  late EmployeeTypeService _employeeTypeService;

  late EmployeeService _employeeService;

  late DepartmentService _departmentService;

  late QRCodeSettingService _qrCodeSettingService;

  ApiProvider._internal() {
    _apiService =
        ApiService('https://devinsofthrmsystemdashapi.azurewebsites.net/api');

    _companyService = CompanyService(_apiService);

    _employeeTypeService = EmployeeTypeService(_apiService);

    _employeeService = EmployeeService(_apiService);

    _departmentService = DepartmentService(_apiService);

    _qrCodeSettingService = QRCodeSettingService(_apiService);
  }

  CompanyService get companyService => _companyService;

  EmployeeTypeService get employeeTypeService => _employeeTypeService;

  EmployeeService get employeeService => _employeeService;

  DepartmentService get departmentService => _departmentService;

  QRCodeSettingService get qrCodeSettingService => _qrCodeSettingService;
}
