one sig LIM {
	users: some Users
}

some abstract sig Users {}

//Every user type is a subcategory of Users. So we have declared the signature Users as Abstract.

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
-----------------------------------------------
fact user {
	users = LIM -> Doctor + 
			LIM -> Patient +
			LIM -> LabExpert +
			LIM -> SystemAdministrator
}

fact sysAdminAccess{
	one s: SystemAdministrator | all u: (Users - SystemAdministrator) | u in s.(s.data)
}

fact singlePatientForTest{
	all t: Test | one p: Patient | t in p.tests
}
-----------------------------------------------
assert oneDoctorPerTest{
	all t: Test | one d: Doctor | t.doctor = d
}

assert oneLabExpertPerTest{
	all t: Test | one l: LabExpert | t.labExpert = l
}

assert someTestPerDoctor{
	all d: Doctor | some t: Test | t.doctor = d
}
-----------------------------------------------
fun doctorLookup(d: Doctor) : set Doctor {
	d.(*doctor)
}

fun patientLookup(p: Patient, t: Test) : set Test {
	(p.tests)
}

fun labExpertLookup(l: LabExpert) : set LabExpert {
	l.(*labExpert)
}
-----------------------------------------------
pred show{
		all p: Patient | some t: Test | t in p.tests
		all p1: Patient | all p2:(Patient - p1) | no p1.tests & p2.tests
}

pred testsPerPatient{
	all p: Patient | #(p.tests) > 0
}
-----------------------------------------------
//run doctorLookup for 10 Users, 10 Test, 1 Doctor

//run patientLookup for 10 Users, 3 Patient, 6 Test

//run labExpertLookup for 10 Users, 5 Patient, 5 Test, 1 LabExpert

//check someTestPerDoctor

run testsPerPatient for 10

run show for exactly 10 Users, exactly 5 Patient, exactly 10 Test

