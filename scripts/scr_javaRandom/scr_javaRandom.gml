function Random(seed = undefined) constructor
{
    seed_hi = 0;
    seed_lo = 0;

    BASE = 16777216;
    MASK = 16777215;

    MULT_HI = 0x5DE;
    MULT_LO = 0xECE66D;
    ADDEND = 0xB;

	self.seed = seed;
    if (is_undefined(seed))
	{
		randomize();
        self.seed = random_get_seed();
	}
	
	SetSeed = function(value)
    {
        var s = ((value % 281474976710656) + 281474976710656) % 281474976710656;

        var hi = floor(s / BASE);
        var lo = s - hi * BASE;

        seed_hi = hi ^ MULT_HI;
        seed_lo = lo ^ MULT_LO;
    }

	SetSeed(self.seed);

    Advance = function()
    {
        var v = seed_lo * MULT_LO + ADDEND;

        var carry = floor(v / BASE);
        seed_lo = v - carry * BASE;

        seed_hi = (seed_hi * MULT_LO + seed_lo * 0 + carry) % BASE;
    }

    Next = function(bits)
    {
        var old_lo = seed_lo;
        var old_hi = seed_hi;

        var v = old_lo * MULT_LO + ADDEND;

        var carry = floor(v / BASE);
        seed_lo = v - carry * BASE;

        seed_hi = (old_hi * MULT_LO + old_lo * MULT_HI + carry) % BASE;

        if (bits <= 24) {
            return floor(seed_hi / power(2, 24 - bits));
        }

        var result = seed_hi * power(2, bits - 24) + floor(seed_lo / power(2, 48 - bits));

        if (bits == 32 && result >= 2147483648)
            result -= 4294967296;

        return result;
    }

    NextInt = function(n = undefined)
    {
        if (is_undefined(n))
            return Next(32);

        if (n <= 0 || n > 2147483647)
            throw ("n must be positive and <= 2147483647");

        var bits;
        var val;

        if ((n & (-n)) == n)
		{
            bits = Next(31);

            var q = floor(bits / 65536);
            var r = bits - q * 65536;

            return floor((q * n) / 32768 + (r * n) / 2147483648);
        }

        do
		{
            bits = Next(31);
            val = bits % n;

        }
		until (bits - val + (n - 1) <= 2147483647);

        return val;
    }
	
    NextBoolean = function()
    {
        return Next(1) != 0;
    }

    NextFloat = function()
    {
        return Next(24) / 16777216;
    }

    NextDouble = function()
    {
        return (Next(26) * 134217728 + Next(27)) / 9007199254740992;
    }

    NextBytes = function(bytes)
    {
        var i = 0;
        var len = array_length(bytes);

        while (i < len)
        {
            var rnd = NextInt();

            var n = min(len - i, 4);

            repeat (n)
            {
                bytes[i] = rnd & 255;
                rnd = floor(rnd / 256);
                i++;
            }
        }

        return bytes;
    };

    NextLong = function()
    {
        var high = Next(32);
        var low = Next(32);

        return [high, low];
    }
	
	nextNextGaussian = 0;
	haveNextNextGaussian = false;
	
	NextGaussian = function()
	{
		if (haveNextNextGaussian)
		{
		    haveNextNextGaussian = false;
		    return nextNextGaussian;
		}
		else
		{
		    var v1, v2, s;
		    do
			{
			    v1 = 2 * NextDouble() - 1;
			    v2 = 2 * NextDouble() - 1;
			    s = v1 * v1 + v2 * v2;
			}
			until (s > 0 && s < 1);

			var multiplier = sqrt((-2 * ln(s)) / s);
		    nextNextGaussian = v2 * multiplier;
		    haveNextNextGaussian = true;
		    return v1 * multiplier;
		}
	}
	
	GetSeed = function() { return seed; }
}