sig LIM{
	users: one Users
}

abstract sig Users{
}

sig test{
	doctor: Doctors,
	labExpert: LabExperts
}

some sig Doctors extends Users{
}

some sig Patients extends Users{
	tests: set test
}{
	all p: Patients| some p.tests
}

some sig LabExperts extends Users{
}

some sig SystemAdministrator extends Users{
	data: LIM
}
