Elm.Native.Meta = {};
Elm.Native.Meta.make = function(localRuntime) {
    localRuntime.Native = localRuntime.Native || {};
    localRuntime.Native.Meta = localRuntime.Native.Meta || {};
    if (localRuntime.Native.Meta.values)
    {
        return localRuntime.Native.Meta.values;
    }

    $Native$Show = Elm.Native.Show.make(localRuntime);
    var _toString = $Native$Show.toString;


    var nameOf = function nameOf(obj){
        return obj.ctor;
    };

    var switchType = function switchType(_left, right){
        var left = Object.freeze(_left);
        left.ctor = right.ctor;
        return left;
    };

    var fmap = function fmap(f, left){
        if (typeof left._0 === "undefined"){
            return left;
        }

        var _left = left;

        _left._0 = f(left._0);


        console.log(left, _left);

        return _left;
    };


    return Elm.Native.Meta.values = {
        nameOf: nameOf,
        switchType: F2(switchType),
        fmap: F2(fmap)
    };
};