Elm.Native.Meta = {};
Elm.Native.Meta.make = function(localRuntime) {
    localRuntime.Native = localRuntime.Native || {};
    localRuntime.Native.Meta = localRuntime.Native.Meta || {};
    if (localRuntime.Native.Meta.values)
    {
        return localRuntime.Native.Meta.values;
    }

    $Native$Debug = Elm.Native.Debug.make(localRuntime);
    $Elm$List = Elm.Native.List.make(localRuntime);


    var nameOf = function nameOf(obj){
        return obj.ctor;
    };

    var switchType = function switchType(_left, right){
        var left = _left;
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

    var getter = function getter(f, getter, left){
        if (typeof left !== "object" || typeof left.ctor !== "undefined" ){
            $Native$Debug.crash("Only records can have setters!");
        }

        var keys = Object.keys(left);
        var name = null;

        for (var i = 0; i < keys.length; i++){
            if (left[keys[i]] === getter){
                name = keys[i];
                break;
            }
        }

        // this should be impossible, but better make sure
        if (name === null){
            $Native$Debug.crash("Name not found in record!");
        }


        Object.defineProperty(
            left,
            name,
            { get : function() {
                console.log("this", this);
                return f(this);
            }}
        );

        return left;
    };

    var createGetter = function(f){
        console.log(f);
    };

    var banana = function(a){
        console.log(a);
        return a;
    };

    var allPossibleActions = function(f){

        var fas = f.func.toString();

        var patt = /case "(.*)"/g;

        var matches = [];
        while( (match = patt.exec(fas)) != null ) {
                matches.push(match[1]);
        }

        var actions = matches.map(function(name){
            return {
                'ctor': name
            };
        });

        actions.push(
            { ctor: "Noop" }
        );

        return $Elm$List.fromArray(actions);

    };

    return Elm.Native.Meta.values = {
        nameOf: nameOf,
        switchType: F2(switchType),
        fmap: F2(fmap),
        getter: F3(getter),
        createGetter: createGetter,
        banana: banana,
        allPossibleActions: allPossibleActions
    };
};
