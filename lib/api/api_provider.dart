import 'services/api_service.dart';
import 'services/auth_service.dart';
import 'services/billing_information_service.dart';
import 'services/company_service.dart';
import 'services/department_service.dart';
import 'services/employee_service.dart';
import 'services/employee_type_service.dart';
import 'services/leave_service.dart';
import 'services/qr_code_setting_service.dart';
import 'services/shift_service.dart';
import 'services/users_entry_exit_event_service.dart';
import 'services/work_entry_exit_event_service.dart';

class ApiProvider {
  static final ApiProvider _instance = ApiProvider._internal();
  factory ApiProvider() => _instance;

  late AuthService _authService;

  late ApiService _dashApiService;

  late ApiService _mobilApiService;

  late ApiService _authApiService;

  late CompanyService _companyService;

  late EmployeeTypeService _employeeTypeService;

  late EmployeeService _employeeService;

  late DepartmentService _departmentService;

  late QRCodeSettingService _qrCodeSettingService;

  late WorkEntryExitEventService _workEntryExitEventService;

  late UsersEntryExitEventService _usersEntryExitEventService;

  late ShiftService _shiftService;

  late LeaveService _leaveService;

  late BillingInformationService _billingInformationService;

  ApiProvider._internal() {
    _dashApiService =
        ApiService('https://devinsofthrmsystemdashapi.azurewebsites.net/api');

    _mobilApiService =
        ApiService('https://devinsofthrmsystemmobileapi.azurewebsites.net/api');

    _authApiService =
        ApiService('https://devinsofthrmsystemdashapi.azurewebsites.net');

    _authService = AuthService(_authApiService);

    _companyService = CompanyService(_dashApiService);

    _employeeTypeService = EmployeeTypeService(_dashApiService);

    _employeeService = EmployeeService(_dashApiService);

    _departmentService = DepartmentService(_dashApiService);

    _qrCodeSettingService = QRCodeSettingService(_dashApiService);

    _workEntryExitEventService = WorkEntryExitEventService(_mobilApiService);

    _usersEntryExitEventService = UsersEntryExitEventService(_mobilApiService);

    _shiftService = ShiftService(_dashApiService);

    _leaveService = LeaveService(_dashApiService);

    _billingInformationService = BillingInformationService(_dashApiService);
  }

  AuthService get authService => _authService;

  CompanyService get companyService => _companyService;

  EmployeeTypeService get employeeTypeService => _employeeTypeService;

  EmployeeService get employeeService => _employeeService;

  DepartmentService get departmentService => _departmentService;

  QRCodeSettingService get qrCodeSettingService => _qrCodeSettingService;

  WorkEntryExitEventService get workEntryExitEventService =>
      _workEntryExitEventService;

  UsersEntryExitEventService get usersEntryExitEventService =>
      _usersEntryExitEventService;

  ShiftService get shiftService => _shiftService;

  LeaveService get leaveService => _leaveService;

  BillingInformationService get billingInformationService =>
      _billingInformationService;
}
