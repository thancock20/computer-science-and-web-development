// Just me playing around with creating a module

// Checks if old enough to perform activity
const ageChecker = function(activity, minimumAge) {
  function tooYoung() {
    console.log(`Sorry. You're not old enough to ${activity}`);
  }

  function rightAge() {
    console.log(`Congratulations! You're just old enough to ${activity}`);
  }

  function plentyOld() {
    console.log(`You're plenty old enough to ${activity}`);
  }

  function changeMinAge(newMinAge) {
    minimumAge = newMinAge;
  };

  function checkAge(age) {
    if (age < minimumAge) return tooYoung();
    if (age === minimumAge) return rightAge();
    return plentyOld();
  }

  return {
    changeMinAge: changeMinAge,
    checkAge: checkAge
  };
};

// example usage

// Lives in the U.S.A
const cigs = ageChecker('smoke cigarettes', 18);
const beer = ageChecker('drink beer', 21);

// Check
cigs.checkAge(20); // 'You're plenty old enough to smoke cigarettes'
beer.checkAge(20); // 'Sorry. You're not old enough to drink beer'

// Moves to Japan
cigs.changeMinAge(20);
beer.changeMinAge(20);

// now check
cigs.checkAge(20); // 'Congratulations! You're just old enough to smoke cigarettes'
beer.checkAge(20); // 'Congratulations! You're just old enough to drink beer'
