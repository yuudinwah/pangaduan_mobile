String url = 'http://192.168.49.17:8000/api';
// Auth URL
Uri authLoginUrl = Uri.parse('$url/auth/login');
Uri authRegisterUrl = Uri.parse('$url/auth/register');
Uri authGetUrl = Uri.parse('$url/auth/get');
// Dashboard URL
Uri dashboardAdminUrl = Uri.parse('$url/dashboard/admin');
// Case URL
Uri caseAddUrl = Uri.parse('$url/case/add');
Uri caseDeleteUrl = Uri.parse('$url/case/delete');
Uri caseFetchUrl = Uri.parse('$url/case/fetch');
Uri caseGetUrl = Uri.parse('$url/case/get');
Uri caseUpdateUrl = Uri.parse('$url/case/update');
// Case Response URL
Uri caseResponseAddUrl = Uri.parse('$url/case-response/add');
Uri caseResponseDeleteUrl = Uri.parse('$url/case-response/delete');
Uri caseResponseFetchUrl = Uri.parse('$url/case-response/fetch');
Uri caseResponseGetUrl = Uri.parse('$url/case-response/get');
// Log URL
Uri logFetchUrl = Uri.parse('$url/log/fetch');
// User URL
Uri userAddUrl = Uri.parse('$url/user/add');
Uri userDeleteUrl = Uri.parse('$url/user/delete');
Uri userFetchUrl = Uri.parse('$url/user/fetch');
Uri userGetUrl = Uri.parse('$url/user/get');