function Random(_seed = 0) constructor
{
	seedHi = 0;
	seedLo = 0;
	haveGauss = false;
	savedGauss = 0;

	static setSeed = function(_newSeed)
	{
		var _scrambled = (int64(_newSeed) ^ $5DEECE66D) & $FFFFFFFFFFFF;
		seedLo = real(_scrambled & $FFFFFF);
		seedHi = real((_scrambled >> 24) & $FFFFFF);
		haveGauss = false;
	}

	static nextBits = function(_numBits)
	{
		var _oldLo = seedLo;
		var _prodLo = _oldLo * $ECE66D + 11;
		seedLo = real(_prodLo & $FFFFFF);
		seedHi = real((seedHi * $ECE66D + _oldLo * $5DE + (_prodLo >> 24)) & $FFFFFF);

		var _result = real(((int64(seedHi) << 24) | int64(seedLo)) >> (48 - _numBits));
		if (_numBits == 32 && _result >= 2147483648)
			_result -= 4294967296;
		return _result;
	}

	static nextInt = function(_bound = undefined)
	{
		if (is_undefined(_bound))
			return nextBits(32);
		return nextIntBound(_bound);
	}

	static nextIntBound = function(_bound)
	{
		if ((_bound & -_bound) == _bound)
			return real((_bound * nextBits(31)) >> 31);
		var _bitsVal, _modVal;
		do
		{
			_bitsVal = nextBits(31);
			_modVal  = _bitsVal mod _bound;
		} 
		until (_bitsVal - _modVal + (_bound - 1) < 2147483648);
		return _modVal;
	}

	static nextIntRange = function(_min, _max)
	{
		return _min + nextIntBound(_max - _min);
	}

	static nextLong = function()
	{
		var _high = int64(nextBits(32));
		var _low  = nextBits(32);
		return (_high << 32) + _low;
	}

	static nextBoolean = function()
	{
		return nextBits(1) != 0;
	}

	static nextFloat = function()
	{
		return nextBits(24) / 16777216;
	}

	static nextDouble = function()
	{
		var _high = nextBits(26);
		var _low  = nextBits(27);
		return (_high * 134217728 + _low) / 9007199254740992;
	}

	static nextGaussian = function()
	{
		if (haveGauss)
		{
			haveGauss = false;
			return savedGauss;
		}

		var _v1, _v2, _s;
		do
		{
			_v1 = 2 * nextDouble() - 1;
			_v2 = 2 * nextDouble() - 1;
			_s = _v1 * _v1 + _v2 * _v2;
		}
		until (_s < 1 && _s != 0)

		var _multiplier = sqrt(-2 * ln(_s) / _s);
		savedGauss = _v2 * _multiplier;
		haveGauss = true;
		return _v1 * _multiplier;
	}

	setSeed(_seed);
}