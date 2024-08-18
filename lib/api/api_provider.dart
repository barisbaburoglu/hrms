import 'package:hrms/api/services/department_service.dart';
import 'package:hrms/api/services/employee_type_service.dart';
import 'package:hrms/api/services/qr_code_setting_service.dart';
import 'package:hrms/api/services/work_entry_exit_event_service.dart';

import 'services/api_service.dart';
import 'services/auth_service.dart';
import 'services/company_service.dart';
import 'services/employee_service.dart';

class ApiProvider {
  static final ApiProvider _instance = ApiProvider._internal();
  factory ApiProvider() => _instance;

  late ApiService _dashApiService;

  late ApiService _mobilApiService;

  late ApiService _authApiService;

  late CompanyService _companyService;

  late EmployeeTypeService _employeeTypeService;

  late EmployeeService _employeeService;

  late DepartmentService _departmentService;

  late QRCodeSettingService _qrCodeSettingService;

  late WorkEntryExitEventService _workEntryExitEventService;

  late AuthService _authService;

  ApiProvider._internal() {
    _dashApiService =
        ApiService('https://devinsofthrmsystemdashapi.azurewebsites.net/api');

    _mobilApiService =
        ApiService('https://devinsofthrmsystemmobileapi.azurewebsites.net/api');

    _authApiService =
        ApiService('https://devinsofthrmsystemmobileapi.azurewebsites.net');

    _companyService = CompanyService(_dashApiService);

    _employeeTypeService = EmployeeTypeService(_dashApiService);

    _employeeService = EmployeeService(_dashApiService);

    _departmentService = DepartmentService(_dashApiService);

    _qrCodeSettingService = QRCodeSettingService(_dashApiService);

    _workEntryExitEventService = WorkEntryExitEventService(_mobilApiService);

    _authService = AuthService(_authApiService);
  }

  CompanyService get companyService => _companyService;

  EmployeeTypeService get employeeTypeService => _employeeTypeService;

  EmployeeService get employeeService => _employeeService;

  DepartmentService get departmentService => _departmentService;

  QRCodeSettingService get qrCodeSettingService => _qrCodeSettingService;

  WorkEntryExitEventService get workEntryExitEventService =>
      _workEntryExitEventService;

  AuthService get authService => _authService;
}
