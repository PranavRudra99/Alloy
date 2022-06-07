one sig LIM {
	users: some Users
}

some abstract sig Users {}

some sig Doctor extends Users {}

some sig Patient extends Users {
	 tests: set Test
}

some sig LabExpert extends Users {}

one sig SystemAdministrator extends Users {
	data: SystemAdministrator -> (Users - SystemAdministrator)
}

sig Test{
	doctor:  one Doctor,
	labExpert: one LabExpert
}

fact user {
	users = LIM -> Doctor + 
			LIM -> Patient +
			LIM -> LabExpert +
			LIM -> SystemAdministrator
}

fun doctorLookup(d: Doctor) : set Doctor {
	d.(*doctor)
}

fun patientLookup(p: Patient, t: Test) : set Test {
	(p.tests)
}

fun labExpertLookup(l: LabExpert) : set LabExpert {
	l.(*labExpert)
}

pred show{
	one s: SystemAdministrator | all u: (Users - SystemAdministrator) | u in s.(s.data)
	all p: Patient | some t: Test | t in p.tests
	all t: Test | one p: Patient | t in p.tests
	all p1: Patient | all p2:(Patient - p1) | no p1.tests & p2.tests
}

//run doctorLookup for 10 Users, 10 Test, 1 Doctor

//run patientLookup for 10 Users, 3 Patient, 6 Test

//run labExpertLookup for 10 Users, 5 Patient, 5 Test, 1 LabExpert

run show for exactly 10 Users, exactly 5 Patient, exactly 10 Test

